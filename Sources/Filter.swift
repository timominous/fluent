public class CompareFilter: Filter {
	public enum Comparison: String {
		case Equals = "="
		case NotEquals = "!="
		case GreaterThanOrEquals = ">="
		case LessThanOrEquals = "<="
		case GreaterThan = ">"
		case LessThan = "<"
	}

	public let key: String
	public let value: String
	public let comparison: Comparison
	public let joinOperator: FilterOperator

	init(key: String, value: String, comparison: Comparison, joinOperator: FilterOperator) {
		self.key = key
		self.value = value
		self.comparison = comparison
		self.joinOperator = joinOperator
	}

	public var filterString: String {
		return "`\(key)` \(comparison.rawValue) '\(value)'"
	}
}

public class SubsetFilter: Filter {
	public enum Comparison: String {
		case In = "IN"
		case NotIn = "NOT IN"
	}

	public let key: String
	public let superSet: [String]
	public let comparison: Comparison
	public let joinOperator: FilterOperator

	init(key: String, superSet: [String], comparison: Comparison, joinOperator: FilterOperator) {
		self.key = key
		self.superSet = superSet
		self.comparison = comparison
		self.joinOperator = joinOperator
	}

	var superSetString: String {
		let elements = superSet.map({ "'\($0)'" })
		return "(" + elements.joinWithSeparator(",") + ")"
	}

	public var filterString: String {
		return "`\(key)` \(comparison.rawValue) \(superSetString)"
	}
}

public protocol Filter {
	var joinOperator: FilterOperator { get }
	var filterString: String { get }
}

public enum FilterOperator: String {
	case And = "AND"
	case Or = "OR"
	case None = ""
}
