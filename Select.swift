//
//  Select.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 31/12/2022.
//

import Foundation

extension DataManager
{
    //Found the number of records stored in a table
    func countRows(in tableName: String) -> Int
    {
        //If the table exists
        if tableExists(named: tableName)
        {
            let query = "SELECT COUNT(*) from \(tableName)"
         
            //
            if let statement = prepare(query)
            {
                while rowExists(in: statement)
                {
                    return getValue(column: 1, in: statement).integer
                }
            }
        }
        
        return 0
    }
    
    /*
    //Load objects
    func loadObjects() -> [Object]
    {
        //The query to search the database
        let query = "SELECT fieldText, fieldInteger, fieldDouble, fieldBool FROM tableName"
        
        //The search results will be stored in this array
        var objects = [Object]()
        
        //If the query can be prepared (run) in the database
        if let statement = prepare(query)
        {
            //Bind the search to to the ? in the WHERE clause of the query in the form of text
            while rowExists(in: statement)
            {
                //Get the values from the columns in the query
                
                //Get the value for column one in the query as an integer
                let id = getValue(column: 1, in: statement).integer
                let string = getValue(column: 2, in: statement).text
                let integer = getValue(column: 3, in: statement).integer
                let double = getValue(column: 4, in: statement).double
                let bool = getValue(column: 5, in: statement).bool
                
                //Create a new object using the values found
                let object = Object(id: id, variableString: string, variableInteger: integer, variableDouble: double, variableBool: bool)
                
                //Add the new object to the array of objects that will be returned
                objects.append(object)
            }
            
            //Close the statement, clearing the bindings so it can be used in the future
            close(statement)
        }
        
        //Return the searched, created and stored in the objects array
        return objects
    }*/
    
    /*
    //Use the search term to search the table in the database for specific records
    func loadSearchedObjects(with searchTerm: String) -> [Object]
    {
        //The query to search the database
        let query = "SELECT id, fieldText, fieldInteger, fieldDouble, fieldBool FROM tableName WHERE fieldText LIKE ?"
        
        //Alternative queries with a search term
        //let query = "SELECT id, fieldText, fieldInteger, fieldDouble, fieldBool FROM tableName WHERE fieldText = ?"
        //let query = "SELECT id, fieldText, fieldInteger, fieldDouble, fieldBool FROM tableName WHERE fieldText = ? AND fieldInteger > ?"
        //let query = "SELECT id, fieldText, fieldInteger, fieldDouble, fieldBool FROM tableName WHERE fieldText = ? OR fieldInteger <= ?"
        
        //The search results will be stored in this array
        var objects = [Object]()
        
        //If the search term is not empty and the query can be prepared (run) in the database
        if !searchTerm.isEmpty, let statement = prepare(query)
        {
            //Bind the search to to the ? in the WHERE clause of the query in the form of text
            //The % after the search term will find any text that starts with the search term
            //A % before the search term will find any text that ends with the search term
            //% + searchTerm + % will find any text that contains the search term, this is the slowest form of search
            //Binding will increase security reducing the risk of SQL injection
            bind(value: .text(searchTerm + "%"), to: 1, in: statement)
            
            //Run the query and loop while there are row results that have not been read
            while rowExists(in: statement)
            {
                //Get the values from the columns in the query
                
                //Get the value for column one in the query as an integer
                let id = getValue(column: 1, in: statement).integer
                let string = getValue(column: 2, in: statement).text
                let integer = getValue(column: 3, in: statement).integer
                let double = getValue(column: 4, in: statement).double
                let bool = getValue(column: 5, in: statement).bool
                
                //Create a new object using the values found
                let object = Object(id: id, variableString: string, variableInteger: integer, variableDouble: double, variableBool: bool)
                
                //Add the new object to the array of objects that will be returned
                objects.append(object)
            }
            
            //Close the statement, clearing the bindings so it can be used in the future
            close(statement)
        }
        
        //Return the searched, created and stored in the objects array
        return objects
    }*/
}
