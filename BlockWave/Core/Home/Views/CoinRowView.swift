//
//  CoinRowView.swift
//  BlockWave
//
//  Created by Mohamad Farhan on 19/08/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showColumnHolding: Bool
    
    var body: some View {
        HStack (spacing: 0) {
            leftColumn
            Spacer()
            if showColumnHolding {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Preview:PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showColumnHolding: true)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)
    }
    
}


extension CoinRowView {
    private var leftColumn: some View {
        HStack (spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
            Text(coin.name.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack (alignment:.trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberToString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment:.trailing) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0
                    ? Color.theme.green
                    : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
