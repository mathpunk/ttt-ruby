require "io"

describe MockIO do
  it "'say' appends the message" do
    io = MockIO.new
    message = "Twas brillig, and the slithy toves"
    io.say(message)
    expect(io.messages).to include message
  end

  it "answers with its preloaded answers, in the order given" do
    io = MockIO.new(answers: ["Yes, sir", "No, sir", "Three bags full, sir"])
    answer = io.ask
    expect(answer).to eq "Yes, sir"

    answer = io.ask
    expect(answer).to eq "No, sir"

    answer = io.ask
    expect(answer).to eq "Three bags full, sir"
  end

  it "raises an error when it is asked a question but has run out of answers" do
    io = MockIO.new(answers: ["Yes, sir", "No, sir", "Three bags full, sir"])
    3.times { |_| io.ask }
    expect{io.ask}.to raise_error InsufficientTestAnswersError
  end

end


