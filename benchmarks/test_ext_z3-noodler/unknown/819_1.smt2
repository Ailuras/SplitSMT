(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3412 0)
(declare-sort var3438 0)
(declare-sort var52 0)
(declare-sort var2439 0)
(declare-sort var2744 0)
(declare-sort var215 0)
(declare-sort var1298 0)
(declare-sort var1474 0)
(declare-sort var1246 0)
(declare-sort var3642 0)
(declare-sort var1342 0)
(declare-sort var210 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun function/1094165038 (var3412) var2744)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun rule/1094165038 (var3412) String)
(declare-fun var1474_getMethodName/-516674313 (var52) String)
(declare-fun var1246_getContext/-1746756582 () var1246)
(declare-fun getUrl/-581253229 (var1246) var3642)
(declare-fun append/-1031950772 (String var1342) String)
(declare-fun cast-from-var3642-to-var1342 (var3642) var1342)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1298_error/377575788 (var1298 String String String String var210) void)
(declare-fun cast-from-var215-to-var210 (var215) var210)
(declare-const null-var3412 var3412)
(declare-const null-var3438 var3438)
(declare-const null-var52 var52)
(declare-const null-var2439 var2439)
(declare-const null-var215 var215)
(declare-const var3412-logger var1298)
(declare-const var2871 var3412) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter 
(assert (not (= var2871 null-var3412)))
(declare-const var3670 var3438) ; Statement: r1 := @parameter0: javax.script.Bindings 
(assert (not (= var3670 null-var3438)))
(declare-const var1217 var52) ; Statement: r10 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1217 null-var52)))
(declare-const var2859 var2439) ; Statement: r19 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var2859 null-var2439)))
(define-const var3306 var2744 (function/1094165038 var2871)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.CompiledScript function> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2837 var215) ; Statement: $r4 := @caughtexception 
(assert (not (= var2837 null-var215)))
(define-const var1859 var1298 var3412-logger) ; Statement: $r6 = <org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2416 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2416)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2416!1 String)
(assert (= var2416!1 ""))
(assert true)
(define-const var3245 String (append/672562846 var2416!1 "Script route error, rule has been ignored. rule: ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Script route error, rule has been ignored. rule: ") 
(declare-const var2416!2 String)
(assert (= var2416!2 (str.++ var2416!1 "Script route error, rule has been ignored. rule: ")))
(define-const var3799 String (rule/1094165038 var2871)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule> 
(assert true)
(define-const var131 String (append/672562846 var3245 var3799)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3245!1 String)
(assert (= var3245!1 (str.++ var3245 var3799)))
(assert true)
(define-const var3635 String (append/672562846 var131 ", method:")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method:") 
(declare-const var131!1 String)
(assert (= var131!1 (str.++ var131 ", method:")))
(define-const var1523 String (var1474_getMethodName/-516674313 var1217)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r10) 
(assert true)
(define-const var3186 String (append/672562846 var3635 var1523)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3635!1 String)
(assert (= var3635!1 (str.++ var3635 var1523)))
(assert true)
(define-const var2260 String (append/672562846 var3186 ", url: ")) ; Statement: $r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", url: ") 
(declare-const var3186!1 String)
(assert (= var3186!1 (str.++ var3186 ", url: ")))
(define-const var1035 var1246 var1246_getContext/-1746756582) ; Statement: $r14 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContext getContext()>() 
(assert true)
(define-const var2714 var3642 (getUrl/-581253229 var1035)) ; Statement: $r15 = virtualinvoke $r14.<org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2977 String (append/-1031950772 var2260 (cast-from-var3642-to-var1342 var2714))) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15) 
(declare-const var2260!1 String)
(assert (str.prefixof var2260 var2260!1))
(assert true)
(define-const var823 String (toString/-2075883882 var2977)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1298_error/377575788 var1859 "2-14" "Scriptrouter exec script error" "" var823 (cast-from-var215-to-var210 var2837))) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-14", "Scriptrouter exec script error", "", $r18, $r4) 

(declare-const var1859!1 var1298)
(declare-const var3623 String)
(declare-const var3782 String)
(declare-const var3750 String)
(declare-const var823!1 String)
(declare-const var2837!1 var215)
 ; Statement: return r19 
(check-sat)
; {function/1094165038=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter], javax.script.CompiledScript), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), rule/1094165038=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter], java.lang.String), var1474_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), var1246_getContext/-1746756582=([], org.apache.dubbo.rpc.RpcContext), getUrl/-581253229=([org.apache.dubbo.rpc.RpcContext], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3642-to-var1342=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1298_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var215-to-var210=([javax.script.ScriptException], java.lang.Throwable)}
; {var3412=org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter, var2871=r0, var3438=javax.script.Bindings, var3670=r1, var52=org.apache.dubbo.rpc.Invocation, var1217=r10, var2439=org.apache.dubbo.rpc.cluster.router.state.BitList, var2859=r19, var2744=javax.script.CompiledScript, var3306=$r2, var215=javax.script.ScriptException, var2837=$r4, var1298=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1859=$r6, var2416=$r5, var3245=$r8, var3799=$r7, var131=$r9, var3635=$r12, var1474=org.apache.dubbo.rpc.support.RpcUtils, var1523=$r11, var3186=$r13, var2260=$r16, var1246=org.apache.dubbo.rpc.RpcContext, var1035=$r14, var3642=org.apache.dubbo.common.URL, var2714=$r15, var1342=java.lang.Object, var2977=$r17, var823=$r18, var210=java.lang.Throwable, var3623="2-14", var3782="Scriptrouter exec script error", var3750=""}
; {org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter=var3412, r0=var2871, javax.script.Bindings=var3438, r1=var3670, org.apache.dubbo.rpc.Invocation=var52, r10=var1217, org.apache.dubbo.rpc.cluster.router.state.BitList=var2439, r19=var2859, javax.script.CompiledScript=var2744, $r2=var3306, javax.script.ScriptException=var215, $r4=var2837, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1298, $r6=var1859, $r5=var2416, $r8=var3245, $r7=var3799, $r9=var131, $r12=var3635, org.apache.dubbo.rpc.support.RpcUtils=var1474, $r11=var1523, $r13=var3186, $r16=var2260, org.apache.dubbo.rpc.RpcContext=var1246, $r14=var1035, org.apache.dubbo.common.URL=var3642, $r15=var2714, java.lang.Object=var1342, $r17=var2977, $r18=var823, java.lang.Throwable=var210, "2-14"=var3623, "Scriptrouter exec script error"=var3782, ""=var3750}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter;	r1 := @parameter0: javax.script.Bindings;	r10 := @parameter1: org.apache.dubbo.rpc.Invocation;	r19 := @parameter2: org.apache.dubbo.rpc.cluster.router.state.BitList;	$r2 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.CompiledScript function>;	$r4 := @caughtexception;	$r6 = <org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Script route error, rule has been ignored. rule: ");	$r7 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method:");	$r11 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r16 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", url: ");	$r14 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContext getContext()>();	$r15 = virtualinvoke $r14.<org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.common.URL getUrl()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-14", "Scriptrouter exec script error", "", $r18, $r4);	return r19
;block_num 2