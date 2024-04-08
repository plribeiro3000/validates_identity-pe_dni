# frozen_string_literal: true

require 'validates_identity'
require_relative 'pe_dni/version'

class ValidatesIdentity
  module PeDni
    autoload :Validator, 'validates_identity/pe_dni/validator'
  end
end

ValidatesIdentity.register_person_identity_type('PE_DNI', ValidatesIdentity::PeDni::Validator)
ValidatesIdentity::ShouldaMatchers.register_person_allowed_values('PE_DNI', %w[178011460 17801146D 17801146-0 17801146-D])
ValidatesIdentity::ShouldaMatchers.register_person_disallowed_values('PE_DNI', %w[12345678 178011461 17801146B 1234567890])
