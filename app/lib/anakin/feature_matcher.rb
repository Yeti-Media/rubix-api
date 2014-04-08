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
      results = perform(body)
      Rails.logger.info("MATCHING ANAKIN RESULTS")
      Rails.logger.info(results.inspect)
      if results.is_a?(Array)
        results = refine_result(results)
      end
      results
    end


    private

    def refine_result(results)
  #    [{"category":"PATTERN","requestID":"368254","values":
  #      [{"label":"22","values":
  #        [{"center":{"x":282.621887207031,"y":268.956695556641},"keypoints":[],"label":"8"}]}]}]
      refined_results = []
      results.map do |res|
        res['values'].each do |node_value|
          node_value['values'].each do |value|
            refined_value = value
            pattern = Pattern.find value['label']
            refined_value['label'] = pattern.label
            refined_value['id'] = pattern.id 
            refined_value['url'] = pattern.file.url
            refined_results.push refined_value
          end
        end
      end
      refined_results
    end

    def validate
      true
    end

  end
end
