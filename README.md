# ActiveRecord Humanized Enum (I18n)
Easily translate your Active Record\'s enums.

## Installation
Include to your Gemfile
```ruby
gem 'activerecord_humanized_enum', require: 'active_record/humanized_enum'
```

## Usage

### ActiveRecord integration
The installation automatically self-includes in the ```ActiveRecord::Base```.

### How to use
1. Call the `enum` macro method just like you already do:
```ruby
class User
  enum status: [:enabled, :disabled]
end
```

2. Translate the enums in your YML translation files:
```yaml
pt-BR:
  activerecord:
    attributes:
      user:
        status: Estado
        statuses:
          enabled: Ativo
          disabled: Inativo
```

3. Will be available the following methods:
```ruby
User.humanized_status(:enabled) # Ativo
User.humanized_status(:disnabled) # Inativo

user = User.first
puts user.status # enabled
puts user.humanized_status # Ativo

user.status = :disabled
puts user.humanized_status # Inativo
```

## Related Projects
- [Integration with ActiveAdmin](http://github.com/dhyegofernando/active_admin-activerecord_enum_i18n)

## Maintainer
[Dhyego Fernando](https://github.com/dhyegofernando)
