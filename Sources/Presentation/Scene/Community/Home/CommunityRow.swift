import SwiftUI

struct CommunityRow: View {
    var name: String
    var title: String

    var body: some View {
        HStack(spacing: 38) {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text(name)
                        .font(.system(
                            size: 15,
                            weight: .medium
                        ))
                    Spacer()
                }
                Spacer()
                    .frame(height: 7)
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text(title)
                        .font(.system(
                            size: 13,
                            weight: .medium
                        ))
                    Spacer()
                }
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: 80)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .shadow,
                    radius: 10,
                    x: 0,
                    y: 5)
            Spacer()
        }
    }
}

struct CommunityRow_Previews: PreviewProvider {
    static var previews: some View {
        CommunityRow(name: "응 그래", title: "어쩔티비")
    }
}
