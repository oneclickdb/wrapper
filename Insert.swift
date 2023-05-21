//
//  Insert.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 31/12/2022.
//

import Foundation

extension DataManager
{
    /*
    //Inset a single object
    func insertObject(_ object: Object)
    {
        //Create query
        let query = "INSERT INTO tableName(fieldText, fieldInteger, fieldDouble, fieldBool) VALUES (?, ?, ?, ?)"
        
        //Check the query is valid
        if let statement = prepare(query)
        {
            //Bind the values to the question marks
            bind(value: .text(object.variableString), to: 1, in: statement)
            
            bind(value: .integer(object.variableInteger), to: 2, in: statement)
            
            bind(value: .double(object.variableDouble), to: 3, in: statement)
            
            bind(value: .bool(object.variableBool), to: 4, in: statement)
            
            //Run the query
            runQuery(statement)
            
            close(statement)
        }
    }*/
    
    /*
    //Insert an array of an object
    func insertObjects(_ objects: [Object])
    {
        //Create query
        let query = "INSERT INTO tableName(fieldText, fieldInteger, fieldDouble, fieldBool) VALUES (?, ?, ?, ?)"
        
        //Check the query is valid
        if let statement = prepare(query)
        {
            for object in objects
            {
                //Bind the values to the question marks
                bind(value: .text(object.variableString), to: 1, in: statement)
                
                bind(value: .integer(object.variableInteger), to: 2, in: statement)
                
                bind(value: .double(object.variableDouble), to: 3, in: statement)
                
                bind(value: .bool(object.variableBool), to: 4, in: statement)
                
                //Run the query
                runQuery(statement)
            }
            
            close(statement)
        }
    }*/
}
