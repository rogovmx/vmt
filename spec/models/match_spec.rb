require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should belong_to :team1 }
  it { should belong_to :team2 }

  it { should validate_presence_of :name }

  describe 'player_indicator_complete! method tests' do
    let(:match) { create(:match, :with_team_and_players) }
    let(:indicator) { Indicator.first }
    let(:player) { match.team1.players.first }

    context 'player indicator is not complete' do
      it { expect(player.check_indicator_completed(indicator)).to be_falsey }
    end

    context 'player indicator completed' do
      before { match.player_indicator_complete!(player, indicator) }

      it { expect(player.reload.check_indicator_completed(indicator)).to be_truthy }
    end
  end
end
