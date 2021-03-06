/**
    A dummy `Driver` useful for developing.
*/
public class PrintDriver: Driver {
    public var idKey: String = "foo"
    
    public func execute<T: Model>(_ query: Query<T>) throws -> [[String : Value]] {
        let sql = SQL(query: query)
        
        print("Statement: \(sql.statement) Values: \(sql.values)")
        
        print("Table \(query.entity)")
        print("Action \(query.action)")
        print("Filters \(query.filters)")
        print()
        
        return []
    }
}