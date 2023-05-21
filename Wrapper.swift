//
//  Create.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 29/12/2022.
//

import Foundation
import SQLite3

extension DataManager
{    
    //Prepare the sql for the open database
    func prepare(_ sql: String) -> OpaquePointer?
    {
        var optionalStatement: OpaquePointer?
        
        let result = sqlite3_prepare_v2(db, sql, -1, &optionalStatement, nil)
        
        //There was a problem with the SQL or the statement does not exist (database may not be open/exists)
        guard result == SQLITE_OK, let statement = optionalStatement else
        {
            //Close the statement created in this function
            sqlite3_finalize(optionalStatement)
            print("Invalid SQL preparing query: \n\(sql)")
            return nil
        }
        
        return statement
    }
    
    //Bind a value to the ? in the query of a statement
    func bind(value: Value, to index: Int32, in statement: OpaquePointer)
    {
        let result: Int32
        
        switch value
        {
        case .double(let double): result = sqlite3_bind_double(statement, index, double)
        case .integer(let int): result = sqlite3_bind_int64(statement, index, Int64(int))
        case .bool(let bool):
            
            if bool
            {
                result = sqlite3_bind_int64(statement, index, 1)
            }
            else
            {
                result = sqlite3_bind_int64(statement, index, 0)
            }
            
        case .text(let text): result = sqlite3_bind_text(statement, index, text, -1, SQLITE_TRANSIENT)
        }
        
        if result != SQLITE_OK
        {
            print("Error binding value \(value) to index \(index)")
        }
    }
    
    //Run a query
    func runQuery(_ statement: OpaquePointer)
    {
        if sqlite3_step(statement) == SQLITE_DONE
        {
            //Handle success
        }
        else
        {
            print("Query not successfully executed")
        }
        
        sqlite3_reset(statement)
    }
    
    //Check that a row has not been looped through in the results of a query
    func rowExists(in statement: OpaquePointer) -> Bool
    {
        return sqlite3_step(statement) == SQLITE_ROW
    }
    
    //To retrieve the value for a column
    func getValue(column: Int32, in statement: OpaquePointer) -> (double: Double, integer: Int, bool: Bool, text: String)
    {
        let type = sqlite3_column_type(statement, column - 1)
        
        switch type
        {
        case SQLITE_FLOAT:
            return Value.double(sqlite3_column_double(statement, column - 1)).data
        case SQLITE_INTEGER:
            return Value.integer(Int(sqlite3_column_int64(statement, column - 1))).data
        case SQLITE_TEXT:
            return Value.text(String(describing: String(cString: sqlite3_column_text(statement, column - 1)))).data
        default:
            return Value.text("").data
        }
    }
    
    //Reset the statement so the query can have new binding values
    func reset(_ statement: OpaquePointer)
    {
        sqlite3_reset(statement)
    }
    
    //Close the prepared statement
    func close(_ statement: OpaquePointer)
    {
        sqlite3_finalize(statement)
    }
}

//Data types (values) possible in SQLite, implement using .text(yourString), .integer(yourInteger)
enum Value
{
    case double(Double)
    case integer(Int)
    case bool(Bool)
    case text(String)
    
    var data : (double: Double, integer: Int, bool: Bool, text: String)
    {
        switch self
        {
        case .double(let value): return (double: value, integer: Int(value), bool: value == 1 ? true : false, text: "\(value)")
        case .integer(let value): return (double: Double(value), integer: value, bool: value == 1 ? true : false, text: "\(value)")
        case .bool(let value): return (double: value ? 1 : 0, integer: value ? 1 : 0, bool: value, text: "")
        case .text(let value): return (double: 0, integer: 0, bool: value == "1" ? true : false, text: value)
        }
    }
}

func parseCSV(from api: String) async -> Data
{
    var dictionary = [[String : Any]]()
    
    guard let url = URL(string: api) else { print("Invalid url: \(api)"); return Data() }
    
    do
    {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let csv = data.print
        
        let rows = csv.rows
        
        if let headingRow = rows.first, headingRow.columns.count > 0
        {
            let headings = headingRow.columns
            
            let columnCount = headings.count

            guard rows.count > 1 else { print("CSV contains one row: \n\(api)"); return Data() }
            
            for rowIndex in 1..<rows.count
            {
                let columns = rows[rowIndex].columns
                
                if columns.count == columnCount
                {
                    var newData = [String : Any]()
                    
                    for columnIndex in 0..<columnCount
                    {
                        let heading = headings[columnIndex]
                        
                        let value = columns[columnIndex]
                        
                        newData[heading] = value
                    }
                    
                    dictionary.append(newData)
                }
            }
        }
    }
    catch
    {
        print("Can not get data as a String from the url: \(api)")
    }
    
    guard let json = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else { return Data() }
    
    return json
}
