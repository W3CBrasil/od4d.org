
class FusekiJSONParser
  def convert(json_data)
    json = JSON.parse(json_data)

    json_header = json["head"]["vars"]

    subject_var = json_header[0]
    predicate_var = json_header[1]
    object_var = json_header[2]

    json_triples = json["results"]["bindings"]

    parse_triples(subject_var, predicate_var, object_var, json_triples)
  end

  private
  def parse_triples(subj_var, pred_var, obj_var, json_triples)
    resources = {}
    json_triples.each do |triple|
      subject = get_subject_name(subj_var, triple)
      predicate = get_predicate_name(pred_var, triple)
      object = get_object_value(obj_var, triple)

      subject_hash = get_subject_from_hash(resources, subject)

      add_hash_entry(subject_hash, predicate, object)
    end
    resources
  end

  def get_subject_name(var_name, triple)
    triple[var_name]["value"]
  end

  def get_predicate_name(var_name, triple)
    predicate_url = triple[var_name]["value"]
    predicate = predicate_url.split(/\/|#/)[-1]
    predicate
  end

  def get_object_value(var_name, triple)
    triple[var_name]["value"]
  end

  def get_subject_from_hash(hash, subject)
    subject = subject
    hash[subject] = hash[subject] || {}
  end

  def add_hash_entry(subject_hash, predicate, object)
    if (subject_hash.has_key? predicate) then
      current = subject_hash[predicate]
      if (current.is_a? Array) then
        current.push(object)
      else
        subject_hash[predicate] = [current, object]
      end
    else
      subject_hash[predicate] = object
    end

  end

end
