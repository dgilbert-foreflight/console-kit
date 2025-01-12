/// A type-erased `Command`.
public protocol AnyCommand {
    /// Ascii art header that will be displayed when `--help` is passed.
    var asciiHeader: [String]? { get }
    /// Text that will be displayed when `--help` is passed.
    var help: String { get }
    
    /// Runs the command against the supplied input.
    func run(using context: inout CommandContext) throws
    func outputAutoComplete(using context: inout CommandContext) throws
    func outputHelp(using context: inout CommandContext) throws

    /// Renders the shell completion script functions for the command and any descendent subcommands.
    func renderCompletionFunctions(using context: CommandContext, shell: Shell) -> String
}

extension AnyCommand {
    
    /// How the command should be identified via the console.
    public static var identifier: String {
        return String(describing: Self.self)
            .convertedToSnakeCase()
    }

    public var asciiHeader: [String]? {
        return nil
    }
}

extension AnyCommand {
    public func outputAutoComplete(using context: inout CommandContext) {
        // do nothing
    }

    public func outputHelp(using context: inout CommandContext) {
        // do nothing
    }

    public func renderCompletionFunctions(using context: CommandContext, shell: Shell) -> String {
        return ""
    }
}

extension AnyCommand {
    func outputHelpHeader(using context: inout CommandContext) {
        if let header = asciiHeader {
            context.console.print()
            for line in context.console.center(header) {
                context.console.print(line)
            }
            context.console.print()
        }

        if !self.help.isEmpty {
            let helpText = context.console.center(self.help)
            context.console.print(helpText)
            context.console.print()
        }
    }
}
