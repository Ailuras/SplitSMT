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

(declare-sort var1333 0)
(declare-sort var1558 0)
(declare-sort var141 0)
(declare-sort var47 0)
(declare-sort var2548 0)
(declare-sort var591 0)
(declare-sort var1222 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var141-init () var141)
(declare-fun <init>/-201242697 (var141) void)
(declare-fun applicationModel/-1886801642 (var1333) var47)
(declare-fun var2548_getProperty/-78901247 (var591 String) String)
(declare-fun cast-from-var47-to-var591 (var47) var591)
(declare-fun var1222_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1333 var1333)
(declare-const null-var1558 var1558)
(declare-const var320 var1333) ; Statement: r1 := @this: org.apache.dubbo.common.infra.support.EnvironmentAdapter 
(assert (not (= var320 null-var1333)))
(declare-const var3177 var1558) ; Statement: r14 := @parameter0: java.util.Map 
(assert (not (= var3177 null-var1558)))
(define-const var2216 var141 var141-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2216)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var2216!1 var141)
(define-const var3268 var47 (applicationModel/-1886801642 var320)) ; Statement: $r2 = r1.<org.apache.dubbo.common.infra.support.EnvironmentAdapter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(define-const var2748 String (var2548_getProperty/-78901247 (cast-from-var47-to-var591 var3268) "dubbo.labels")) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>($r2, "dubbo.labels") 
(define-const var866 Bool (var1222_isNotEmpty/-1251449450 var2748)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = r1.<org.apache.dubbo.common.infra.support.EnvironmentAdapter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (= (ite var866 1 0) 0)) ; Cond: $z0 == 0 
(define-const var684 var47 (applicationModel/-1886801642 var320)) ; Statement: $r4 = r1.<org.apache.dubbo.common.infra.support.EnvironmentAdapter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(define-const var789 String (var2548_getProperty/-78901247 (cast-from-var47-to-var591 var684) "dubbo.env.keys")) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>($r4, "dubbo.env.keys") 
(define-const var3853 Bool (var1222_isNotEmpty/-1251449450 var789)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r10) 
 ; Statement: if $z1 == 0 goto return $r0 
(assert (= (ite var3853 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return $r0 
(check-sat)
; {var141-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), applicationModel/-1886801642=([org.apache.dubbo.common.infra.support.EnvironmentAdapter], org.apache.dubbo.rpc.model.ApplicationModel), var2548_getProperty/-78901247=([org.apache.dubbo.rpc.model.ScopeModel, java.lang.String], java.lang.String), cast-from-var47-to-var591=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var1222_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1333=org.apache.dubbo.common.infra.support.EnvironmentAdapter, var320=r1, var1558=java.util.Map, var3177=r14, var141=java.util.HashMap, var2216=$r0, var47=org.apache.dubbo.rpc.model.ApplicationModel, var3268=$r2, var2548=org.apache.dubbo.common.config.ConfigurationUtils, var591=org.apache.dubbo.rpc.model.ScopeModel, var2748=r3, var1222=org.apache.dubbo.common.utils.StringUtils, var866=$z0, var684=$r4, var789=$r10, var3853=$z1}
; {org.apache.dubbo.common.infra.support.EnvironmentAdapter=var1333, r1=var320, java.util.Map=var1558, r14=var3177, java.util.HashMap=var141, $r0=var2216, org.apache.dubbo.rpc.model.ApplicationModel=var47, $r2=var3268, org.apache.dubbo.common.config.ConfigurationUtils=var2548, org.apache.dubbo.rpc.model.ScopeModel=var591, r3=var2748, org.apache.dubbo.common.utils.StringUtils=var1222, $z0=var866, $r4=var684, $r10=var789, $z1=var3853}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2}
;stmts r1 := @this: org.apache.dubbo.common.infra.support.EnvironmentAdapter;	r14 := @parameter0: java.util.Map;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$r2 = r1.<org.apache.dubbo.common.infra.support.EnvironmentAdapter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	r3 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>($r2, "dubbo.labels");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = r1.<org.apache.dubbo.common.infra.support.EnvironmentAdapter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r4 = r1.<org.apache.dubbo.common.infra.support.EnvironmentAdapter: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r10 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.lang.String getProperty(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String)>($r4, "dubbo.env.keys");	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r10);	if $z1 == 0 goto return $r0;	return $r0
;block_num 3