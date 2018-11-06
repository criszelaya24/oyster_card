require 'oystercard'
describe OysterCard do
	describe '#Balance' do
		#it {expect(subject).to respond_to :balance} (Respond to attr)
		it 'Expect that the init balance equal to 0' do
			expect(subject.balance).to eq 0
		end
	end

	describe '#top_up' do
		#it{is_expected.to respond_to(:top_up).with(1).argument} (Respond to a funtion)
		it 'Change the balance when we top up our card' do
			expect{subject.top_up(10)}.to change {subject.balance}.by 10
			# oystercard = OysterCard.new (MY WAY)
			# oystercard.top_up(10)
			# expect(oystercard.balance).to eq 10
		end
		it 'Expect an error when is top up more than the limit' do
			limit = OysterCard::LIMIT
			subject.top_up(limit)
			expect {subject.top_up(1)}.to raise_error 'Limit reached, you can not to up more than 90'
		end

		it 'Expect an error when is top up for first time and the amount is more than the limit' do
			expect {subject.top_up(91)}.to raise_error 'Limit reached, you can not to up more than 90'
		end
	end

	# describe '#Reduct' do
	# 	it{is_expected.to respond_to(:reduct).with(1).argument}
	# 	# it 'Expect an error when try to reduct money and you have 0' do
	# 	# 	expect {subject.reduct(1)}.to raise_error('You do not have money inside to reduct from the card')
	# 	# end

	# 	it 'Change the balance when we reduct from our card' do
	# 		subject.top_up(20)
	# 		expect(subject.reduct(10)).to eq 10
	# 	end
	# end

	describe '#Status_journy' do
		it 'Is initially not in a journey' do
			#expect(subject.in_journey?).to eq false (My way)
			expect(subject).not_to be_in_journey
		end

		it 'Can touch in' do
			subject.top_up(2)
			subject.touch_in
			expect(subject).to be_in_journey
		end

		it 'Can touch out' do
			subject.top_up(2)
			subject.touch_in
			subject.touch_out
			expect(subject).not_to be_in_journey
		end
	end

	describe '#touch in' do
		it 'raise an error when start a journey with not enough money' do
			expect {subject.touch_in}.to raise_error('Insufficient balance to touch in')
		end
	end

	describe '#touch out' do
		it 'Reduce the amount of the journey to your balance' do
			subject.top_up(2)
			subject.touch_in
			expect {subject.touch_out}.to change {subject.balance}.by(-OysterCard::MINIMUN_AMOUNT)
		end
	end
end