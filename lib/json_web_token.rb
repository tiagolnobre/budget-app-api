class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ALGORITHM = "HS256"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM }).first
    HashWithIndifferentAccess.new decoded
  end
end
