module Anakin
  class FeatureMatcher < Client

    def add_indexes(body)
      perform(body.merge(action: 'add_indexes'))
    end

    def update_index(body)
      perform(body.merge(action: 'update_index'))
    end

    def delete_index(body)
      perform(body)
    end

    def matching(user, body)
      body.merge!(action: 'matching', indexes: user.trainers.ids, category: 'matching')
      perform(body)
    end


    private

    def validate
      true
    end

  end
end
