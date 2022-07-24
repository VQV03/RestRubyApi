class Contact < ApplicationRecord

    # Kaminari
    paginates_per 5

    #Associacoes
    belongs_to :kind, optional: true
        #Phones
    has_many :phones
    accepts_nested_attributes_for :phones, allow_destroy: true
        #Address
    has_one :address
    accepts_nested_attributes_for :address, update_only: true

    def as_json(options = {})
        h = super(options)
        h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
        return h
    end

    # def birthdate_br
    #     I18n.l(self.birthdate) unless self.birthdate.blank?
    # end

    # def to_br
    #     {
    #         name: self.name,
    #         email: self.email,
    #         birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?),
    #         # created_at: self.created_at,
    #         # updated_at: self.updated_at,
    #         kind_id: self.kind_id
    #     } 
    # end

    # def author
    #     "Vitor Queiroz"
    # end

    # def kind_description
    #     self.kind.description
    # end

    # def as_json(options={})
    #     super(
    #         root: true, 
    #         methods: [:kind_description, :author]
    #         # include: { kind: { only: :description } }
    #     )
    # end

    # def hello
    #     I18n.t("hello")
    # end

    # def i18n
    #     I18n.default_locale
    # end
end
