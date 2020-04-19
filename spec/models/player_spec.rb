require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to :team }

  it { should validate_presence_of :name }

  describe 'check whether the player has completed a specific indicator at least 1 time in the previous 5 matches of the team' do
    let(:team) { create(:team, :with_all_relations_indicator_false) }
    let(:indicator) { Indicator.first }

    context 'specific indicator not completed' do
      it { expect(team.players.first.check_indicator_completed(indicator)).to be_falsey }
    end

    context 'specific indicator completed' do
      before do
        team.matches.last.player_indicator_complete!(team.players.first, indicator)
      end
      it do
        # puts Match.all.to_yaml
        expect(team.players.first.reload.check_indicator_completed(indicator)).to be_truthy
      end
    end
  end

  describe 'select the Top-5 players by a specific indicator in the team' do
    let(:team) { create(:team, :with_all_relations_indicator_rand) }
    let(:indicator) { Indicator.first }

    context 'check top5' do
      before do
        team.matches.last.player_indicator_complete!(team.players.first, indicator)
      end

      it do
        top5 = Player.top5_by_indicator(indicator, team)

        top5.each do |player|
          expect(player.reload.check_indicator_completed(indicator)).to be_truthy
          expect(player.team).to eq team
        end
      end
    end
  end

  describe 'select the Top-5 players by a specific indicator for all teams' do
    let(:team) { create(:team, :teams_with_all_relations_indicator_rand) }
    let(:team2) { create(:team, :teams_with_all_relations_indicator) }
    let(:indicator) { Indicator.first }

    context 'check top5 for all teams indicator completed' do
      before do
        team.matches.last.player_indicator_complete!(team.players.first, indicator)
      end

      it do
        top5 = Player.top5_by_indicator(indicator)
        # puts top5.to_yaml

        top5.each do |player|
          expect(player.reload.check_indicator_completed(indicator)).to be_truthy
        end
      end
    end

    context 'check top5 for all teams, and players not in the same team' do
      it do
        indicator =
          team2.indicator_values.first.indicator
        top5 = Player.top5_by_indicator(indicator)
        # puts top5.to_yaml
        expect(top5[1].team).to_not eq top5[0].team
      end
    end
  end
end
