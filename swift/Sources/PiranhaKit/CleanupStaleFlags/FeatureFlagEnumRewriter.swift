//
//  FeatureFlagEnumRewriter.swift
//  PiranhaKit
//
//  Created by John Connolly on 2021-09-30.
//

import Foundation
import SwiftSyntax

class FeatureFlagEnumRewriter: SyntaxRewriter {
    
    
    private let flagName: String
    var isFeatureFlagEnum = false
    var isFeatureFlagClass = false
    var cachedEnumName: String?
    
    init(flagName: String) {
        self.flagName = flagName
    }
    
    
    override func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
        isFeatureFlagClass = node.identifier.description == "ObjcFeatureFlagKey"
        return super.visit(node)
    }
    
    
    override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        guard isFeatureFlagClass else {
            return super.visit(node)
        }
        
        if node.description.contains(flagName) {
            return DeclSyntax.init(SyntaxFactory.makeBlankVariableDecl())
        }
        
        return super.visit(node)
    }
    
    
    override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
        isFeatureFlagEnum = node.identifier.description == "FeatureFlagKey"
        return super.visit(node)
    }
    
    override func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
        
        func string(of node: Syntax) -> String {
            let tokenTexts = node.tokens.map { token in token.text }
            return tokenTexts.joined()
        }

        
        guard node.elements.count > 0, isFeatureFlagEnum else {
            return super.visit(node)
        }
        
        
        if let firstElement = node.elements.first(where: { $0.indexInParent == 0 }), string(of: Syntax(firstElement)).contains(flagName) {
            
            return DeclSyntax.init(SyntaxFactory.makeBlankEnumCaseDecl())
        }
        
        return super.visit(node)
    }

}
