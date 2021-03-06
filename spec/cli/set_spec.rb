# encoding: utf-8
require 'helper'

describe T::CLI::Set do

  before do
    rcfile = RCFile.instance
    rcfile.path = fixture_path + "/.trc"
    @t = T::CLI.new
    @old_stderr = $stderr
    $stderr = StringIO.new
    @old_stdout = $stdout
    $stdout = StringIO.new
  end

  after do
    $stderr = @old_stderr
    $stdout = @old_stdout
  end

  describe "#bio" do
    before do
      @t.options = @t.options.merge(:profile => fixture_path + "/.trc")
      stub_post("/1/account/update_profile.json").
        with(:body => {:description => "A mind forever voyaging through strange seas of thought, alone.", :include_entities => "false"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @t.set("bio", "A mind forever voyaging through strange seas of thought, alone.")
      a_post("/1/account/update_profile.json").
        with(:body => {:description => "A mind forever voyaging through strange seas of thought, alone.", :include_entities => "false"}).
        should have_been_made
    end
    it "should have the correct output" do
      @t.set("bio", "A mind forever voyaging through strange seas of thought, alone.")
      $stdout.string.chomp.should == "@testcli's bio has been updated."
    end
  end

  describe "#default" do
    before do
      @t.options = @t.options.merge(:profile => fixture_path + "/.trc")
    end
    it "should have the correct output" do
      @t.set("default", "testcli", "abc123")
      $stdout.string.chomp.should == "Default account has been updated."
    end
  end

  describe "#language" do
    before do
      @t.options = @t.options.merge(:profile => fixture_path + "/.trc")
      stub_post("/1/account/settings.json").
        with(:body => {:lang => "en"}).
        to_return(:body => fixture("settings.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @t.set("language", "en")
      a_post("/1/account/settings.json").
        with(:body => {:lang => "en"}).
        should have_been_made
    end
    it "should have the correct output" do
      @t.set("language", "en")
      $stdout.string.chomp.should == "@testcli's language has been updated."
    end
  end

  describe "#location" do
    before do
      @t.options = @t.options.merge(:profile => fixture_path + "/.trc")
      stub_post("/1/account/update_profile.json").
        with(:body => {:location => "San Francisco", :include_entities => "false"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @t.set("location", "San Francisco")
      a_post("/1/account/update_profile.json").
        with(:body => {:location => "San Francisco", :include_entities => "false"}).
        should have_been_made
    end
    it "should have the correct output" do
      @t.set("location", "San Francisco")
      $stdout.string.chomp.should == "@testcli's location has been updated."
    end
  end

  describe "#name" do
    before do
      @t.options = @t.options.merge(:profile => fixture_path + "/.trc")
      stub_post("/1/account/update_profile.json").
        with(:body => {:name => "Erik Michaels-Ober", :include_entities => "false"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @t.set("name", "Erik Michaels-Ober")
      a_post("/1/account/update_profile.json").
        with(:body => {:name => "Erik Michaels-Ober", :include_entities => "false"}).
        should have_been_made
    end
    it "should have the correct output" do
      @t.set("name", "Erik Michaels-Ober")
      $stdout.string.chomp.should == "@testcli's name has been updated."
    end
  end

  describe "#url" do
    before do
      @t.options = @t.options.merge(:profile => fixture_path + "/.trc")
      stub_post("/1/account/update_profile.json").
        with(:body => {:url => "https://github.com/sferik", :include_entities => "false"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "should request the correct resource" do
      @t.set("url", "https://github.com/sferik")
      a_post("/1/account/update_profile.json").
        with(:body => {:url => "https://github.com/sferik", :include_entities => "false"}).
        should have_been_made
    end
    it "should have the correct output" do
      @t.set("url", "https://github.com/sferik")
      $stdout.string.chomp.should == "@testcli's URL has been updated."
    end
  end

end
