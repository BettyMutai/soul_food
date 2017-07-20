require("bundler/setup")
  Bundler.require(:default)
  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}

  get("/") do
    @tags = Tag.all
    @recipes = Recipe.all
    erb(:index)
  end

  post('/recipes') do
    recipe = params.fetch("recipe")
    instructions = params.fetch('instructions')
    ingredients = params.fetch('ingredients')
    cost = params.fetch("cost")
    tag = Tag.find(params.fetch("tag_id").to_i)
    recipe = Recipe.new(name: recipe, price: cost)
    if recipe.save
      kitchen = Kitchen.new(instructions: instructions, ingredients: ingredients, recipe_id: recipe.id, tag_id: tag.id)
      kitchen.save
      redirect('/recipes/'.concat(recipe.id.to_s))
    else
      erb(:index)
    end
  end

  get('/recipes/:id') do
    @recipe = Recipe.find(params.fetch('id').to_i)
    erb(:recipe)
  end

  post('/tags') do
    tag = Tag.new(name: params.fetch("tag"))
    if tag.save
      redirect('/tags/'.concat(tag.id.to_s))
    else
      erb(:index)
    end
  end

  get('/tags/:id') do
    @tag = Tag.find(params.fetch('id').to_i)
    erb(:tag)
  end

  get('/recipes/:id') do
    @recipe = Recipe.find(params.fetch("id").to_i)
    erb(:recipe)
  end

  patch('/recipes/:id') do
    @recipe = Recipe.find(params.fetch("id").to_i)
    @recipe.update(name: params.fetch("recipe"), price: params.fetch("cost"))
    kitchen = Kitchen.find_by_recipe_id(params.fetch("id").to_i)
    kitchen.update(ingredients: params.fetch("ingredients"), instructions: params.fetch("instructions"))
    erb(:recipe)
  end

  delete('/recipes/:id') do
    @recipe = Recipe.find(params.fetch("id").to_i)
    @kitchen = Kitchen.find_by_recipe_id(params.fetch("id").to_i)
    @kitchen.destroy
    @recipe.destroy
    redirect("/")
  end
