//
//  ProfileScene.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import SwiftUI

struct ProfileScene: View {
    var body: some View {
        NavigationSplitView {
            ProfileSidebar()
        } detail: {
            ProfileDetail()
        }
    }
}

#Preview {
    ProfileScene()
}
