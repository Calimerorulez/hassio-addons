CREATE POLICY "test_update_rls_policy_$%{}[]()&*^!@""'`\/#"
    ON public.test_rls_policy
    FOR UPDATE
    TO public
    USING (true)
    WITH CHECK (name != null);
