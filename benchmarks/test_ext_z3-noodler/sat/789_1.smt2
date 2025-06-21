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

(declare-sort var677 0)
(declare-sort var3184 0)
(declare-sort var2060 0)
(declare-sort var2989 0)
(declare-sort var2025 0)
(declare-sort var3928 0)
(declare-sort var974 0)
(declare-sort var1975 0)
(declare-sort var3243 0)
(declare-sort var3006 0)
(declare-sort var1201 0)
(declare-sort var726 0)
(declare-sort var3786 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3928_getServiceContext/735675290 () var2025)
(declare-fun setInvokers/-1954996930 (var2025 var2060) var2025)
(declare-fun getUrl/776545256 (var3006) var3243)
(declare-fun cast-from-var677-to-var3006 (var677) var3006)
(declare-fun getParameter/448702405 (var3243 String Int) Int)
(declare-fun arr-var726-init () (Array Int var726))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var726 (Int) var726)
(declare-fun String_format/1339386452 (String (Array Int var726)) String)
(declare-fun var3786_info/484404803 (var3786 String) void)
(declare-fun cast-from-var1201-to-var3786 (var1201) var3786)
(declare-fun var2060_size/-959786421 (var2060) Int)
(declare-const null-var677 var677)
(declare-const null-var3184 var3184)
(declare-const null-var2060 var2060)
(declare-const null-var2989 var2989)
(declare-const null-var974 var974)
(declare-const null-var1975 var1975)
(declare-const var677-logger var1201)
(declare-const null-__Array__Int__var726__ (Array Int var726))
(declare-const var527 var677) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker 
(assert (not (= var527 null-var677)))
(declare-const var1097 var3184) ; Statement: r23 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1097 null-var3184)))
(declare-const var168 var2060) ; Statement: r0 := @parameter1: java.util.List 
(assert (not (= var168 null-var2060)))
(declare-const var1400 var2989) ; Statement: r46 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance 
(assert (not (= var1400 null-var2989)))
(define-const var81 var2025 var3928_getServiceContext/735675290) ; Statement: $r1 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
;(assert (setInvokers/-1954996930 var81 var168)) ; Statement: virtualinvoke $r1.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvokers(java.util.List)>(r0) 

(declare-const var81!1 var2025)
(declare-const var168!1 var2060)
(define-const var2798 var974 null-var974) ; Statement: r47 = null 
(define-const var1102 var1975 null-var1975) ; Statement: r48 = null 
(assert true)
(define-const var3871 var3243 (getUrl/776545256 (cast-from-var677-to-var3006 var527))) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1890 Int (getParameter/448702405 var3871 "broadcast.fail.percent" 100)) ; Statement: i4 = virtualinvoke r3.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("broadcast.fail.percent", 100) 
 ; Statement: if i4 < 0 goto $r5 = <org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (< var1890 0)) ; Cond: i4 < 0 
(define-const var1488 var1201 var677-logger) ; Statement: $r5 = <org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2155 (Array Int var726) arr-var726-init) ; Statement: $r4 = newarray (java.lang.Object)[1] 
(define-const var3186 Int (Int_valueOf/-1371140006 var1890)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i4) 
(declare-const var2155!1 (Array Int var726))
(assert (not (= var2155!1 null-__Array__Int__var726__)))
(assert (= (select var2155!1 0) (cast-from-Int-to-var726 var3186))) ; Statement: $r4[0] = $r6 
(define-const var2877 String (String_format/1339386452 "The value corresponding to the broadcast.fail.percent parameter must be between 0 and 100. The current setting is %s, which is reset to 100." var2155!1)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("The value corresponding to the broadcast.fail.percent parameter must be between 0 and 100. The current setting is %s, which is reset to 100.", $r4) 
;(assert (var3786_info/484404803 (cast-from-var1201-to-var3786 var1488) var2877)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7) 

(declare-const var1488!1 var1201)
(declare-const var2877!1 String)
(define-const var1890!1 Int 100) ; Statement: i4 = 100 
(assert true) ; Non Conditional
(define-const var910 Int (var2060_size/-959786421 var168!1)) ; Statement: $i5 = interfaceinvoke r0.<java.util.List: int size()>() 
(define-const var949 Int (* var910 var1890!1)) ; Statement: $i6 = $i5 * i4 
(define-const var3245 Int (div var949 100)) ; Statement: $i7 = $i6 / 100 
(define-const var1377 Int 0) ; Statement: i8 = 0 
(define-const var451 Int 0) ; Statement: i9 = 0 
(define-const var2522 Int (var2060_size/-959786421 var168!1)) ; Statement: $i10 = interfaceinvoke r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i9 >= $i10 goto (branch) 
(assert (>= var451 var2522)) ; Cond: i9 >= $i10 
 ; Statement: if r47 == null goto return r48 
(assert (= var2798 null-var974)) ; Cond: r47 == null 
 ; Statement: return r48 
(check-sat)
; {var3928_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), setInvokers/-1954996930=([org.apache.dubbo.rpc.RpcServiceContext, java.util.List], org.apache.dubbo.rpc.RpcServiceContext), getUrl/776545256=([org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker], org.apache.dubbo.common.URL), cast-from-var677-to-var3006=([org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker], org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), arr-var726-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var726=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var3786_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1201-to-var3786=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var2060_size/-959786421=([java.util.List], int)}
; {var677=org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker, var527=r2, var3184=org.apache.dubbo.rpc.Invocation, var1097=r23, var2060=java.util.List, var168=r0, var2989=org.apache.dubbo.rpc.cluster.LoadBalance, var1400=r46, var2025=org.apache.dubbo.rpc.RpcServiceContext, var3928=org.apache.dubbo.rpc.RpcContext, var81=$r1, var974=org.apache.dubbo.rpc.RpcException, var2798=r47, var1975=org.apache.dubbo.rpc.Result, var1102=r48, var3243=org.apache.dubbo.common.URL, var3006=org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker, var3871=r3, var1890=i4, var1201=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1488=$r5, var726=java.lang.Object, var2155=$r4, var3186=$r6, var2877=$r7, var3786=org.apache.dubbo.common.logger.Logger, var910=$i5, var949=$i6, var3245=$i7, var1377=i8, var451=i9, var2522=$i10}
; {org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker=var677, r2=var527, org.apache.dubbo.rpc.Invocation=var3184, r23=var1097, java.util.List=var2060, r0=var168, org.apache.dubbo.rpc.cluster.LoadBalance=var2989, r46=var1400, org.apache.dubbo.rpc.RpcServiceContext=var2025, org.apache.dubbo.rpc.RpcContext=var3928, $r1=var81, org.apache.dubbo.rpc.RpcException=var974, r47=var2798, org.apache.dubbo.rpc.Result=var1975, r48=var1102, org.apache.dubbo.common.URL=var3243, org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker=var3006, r3=var3871, i4=var1890, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1201, $r5=var1488, java.lang.Object=var726, $r4=var2155, $r6=var3186, $r7=var2877, org.apache.dubbo.common.logger.Logger=var3786, $i5=var910, $i6=var949, $i7=var3245, i8=var1377, i9=var451, $i10=var2522}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker;	r23 := @parameter0: org.apache.dubbo.rpc.Invocation;	r0 := @parameter1: java.util.List;	r46 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance;	$r1 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	virtualinvoke $r1.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvokers(java.util.List)>(r0);	r47 = null;	r48 = null;	r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	i4 = virtualinvoke r3.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("broadcast.fail.percent", 100);	if i4 < 0 goto $r5 = <org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r5 = <org.apache.dubbo.rpc.cluster.support.BroadcastClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = newarray (java.lang.Object)[1];	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i4);	$r4[0] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("The value corresponding to the broadcast.fail.percent parameter must be between 0 and 100. The current setting is %s, which is reset to 100.", $r4);	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7);	i4 = 100;	$i5 = interfaceinvoke r0.<java.util.List: int size()>();	$i6 = $i5 * i4;	$i7 = $i6 / 100;	i8 = 0;	i9 = 0;	$i10 = interfaceinvoke r0.<java.util.List: int size()>();	if i9 >= $i10 goto (branch);	if r47 == null goto return r48;	return r48
;block_num 6