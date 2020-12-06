class Transfer

  attr_accessor :sender, :receiver, :status, :amount, :last_transaction_amount
  attr_writer 
  attr_reader 

  def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
      @last_transaction_amount = 0
  end

  def valid?
    if self.status == "pending" && sender.valid? == true && self.receiver.valid? == true
      true
    else
      false
    end
  end

  def execute_transaction
    if self.valid? == true && self.status != "complete" && sender.balance > self.amount
        sender.balance -= self.amount
        receiver.balance += self.amount
        @last_transaction_amount = self.amount
        self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      receiver.balance -= self.last_transaction_amount
      sender.balance += self.last_transaction_amount
      self.status = "reversed"
    end
  end

end
