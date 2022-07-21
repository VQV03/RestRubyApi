module V1
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :birthdate #, :author

    #Associacoes
    belongs_to :kind do
      link(:related) { v1_contact_kind_url(object.id) }
    end
    #Phones
    has_many :phones do
      link(:related) { v1_contact_phones_url(object.id) }
    end

    #Address
    has_one :address do
      link(:related) { v1_contact_address_url(object.id) }
    end

    # link(:self) { contact_url(object.id) }
    # link(:kind) { kind_url(object.kind.id) }

    # def author
    #   "Vitor Queiroz"
    # end

    meta do
      { author: "Vitor Queiroz" }
    end

    def attributes(*args)
      h = super(*args)
      # h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?) #Formato PT-BR
      h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank? #Formato ISO8601
      h
    end
  end
end
