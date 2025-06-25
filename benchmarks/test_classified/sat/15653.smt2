(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1477 0)
(declare-sort var2753 0)
(declare-sort var3626 0)
(declare-sort var2498 0)
(declare-sort var1953 0)
(declare-sort var1293 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3626_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun isRange/-674317318 (var1477 String) Bool)
(declare-fun var1953_asList/1779083644 ((Array Int var1293)) var2498)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1293__ ((Array Int String)) (Array Int var1293))
(declare-fun var2498_contains/-441121415 (var2498 var1293) Bool)
(declare-fun cast-from-String-to-var1293 (String) var1293)
(declare-const null-var1477 var1477)
(declare-const null-String String)
(declare-const var1803 var1477) ; Statement: r1 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var1803 null-var1477)))
(declare-const var1729 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1729 null-String)))
(declare-const var1867 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var1867 null-String)))
(define-const var3435 Bool (var3626_isBlank/-523695098 (cast-from-String-to-String var1729))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosServiceName: boolean isRange(java.lang.String)>(r0) 
(assert (= (ite var3435 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3707 Bool (isRange/-674317318 var1803 var1729)) ; Statement: $z1 = specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosServiceName: boolean isRange(java.lang.String)>(r0) 
 ; Statement: if $z1 != 0 goto r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (not (= (ite var3707 1 0) 0))) ; Cond: $z1 != 0 
; split operation: var978 = var1729.split(",") ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2665 var2498 (var1953_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var1293__ var978))) ; Statement: $r4 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r2) 
(define-const var2700 Bool (var2498_contains/-441121415 var2665 (cast-from-String-to-var1293 var1867))) ; Statement: $z2 = interfaceinvoke $r4.<java.util.List: boolean contains(java.lang.Object)>(r3) 
 ; Statement: return $z2 
(check-sat)
; {var3626_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), isRange/-674317318=([org.apache.dubbo.registry.nacos.NacosServiceName, java.lang.String], boolean), var1953_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var1293__=([java.lang.String[]], java.lang.Object[]), var2498_contains/-441121415=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var1293=([java.lang.String], java.lang.Object)}
; {var1477=org.apache.dubbo.registry.nacos.NacosServiceName, var1803=r1, var1729=r0, var2753=null_type, var1867=r3, var3626=org.apache.dubbo.common.utils.StringUtils, var3435=$z0, var3707=$z1, var978=r2, var2498=java.util.List, var1953=java.util.Arrays, var1293=java.lang.Object, var2665=$r4, var2700=$z2}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var1477, r1=var1803, r0=var1729, null_type=var2753, r3=var1867, org.apache.dubbo.common.utils.StringUtils=var3626, $z0=var3435, $z1=var3707, r2=var978, java.util.List=var2498, java.util.Arrays=var1953, java.lang.Object=var1293, $r4=var2665, $z2=var2700}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $z1 = specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosServiceName: boolean isRange(java.lang.String)>(r0);	$z1 = specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosServiceName: boolean isRange(java.lang.String)>(r0);	if $z1 != 0 goto r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r4 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>(r2);	$z2 = interfaceinvoke $r4.<java.util.List: boolean contains(java.lang.Object)>(r3);	return $z2
;block_num 3