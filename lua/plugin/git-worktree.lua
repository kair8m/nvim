local git_worktree_status, git_worktree = pcall(require, "git-worktree")
if not git_worktree_status then
    return
end

git_worktree.on_tree_change(function(op, metadata)
    if op == git_worktree.Operations.Switch then
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    end
end)
