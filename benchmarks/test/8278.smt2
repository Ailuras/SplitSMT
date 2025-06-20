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

(declare-sort var1848 0)
(declare-sort var2740 0)
(declare-sort var2535 0)
(declare-sort var2536 0)
(declare-sort var731 0)
(declare-sort var1656 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun build/1692375552 (var2535 var2536) void)
(declare-fun cast-from-var1848-to-var2535 (var1848) var2535)
(declare-fun cast-from-var2740-to-var2536 (var2740) var2536)
(declare-fun check/1938197122 (var1848) var731)
(declare-fun init/1938197122 (var1848) var731)
(declare-fun generic/1938197122 (var1848) String)
(declare-fun var1656_isEmpty/-813097145 (String) Bool)
(declare-fun injvm/1938197122 (var1848) var731)
(declare-fun lazy/1938197122 (var1848) var731)
(declare-fun reconnect/1938197122 (var1848) String)
(declare-fun sticky/1938197122 (var1848) var731)
(declare-fun version/1938197122 (var1848) String)
(declare-fun group/1938197122 (var1848) String)
(declare-const null-var1848 var1848)
(declare-const null-var2740 var2740)
(declare-const null-var731 var731)
(declare-const var2540 var1848) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder 
(assert (not (= var2540 null-var1848)))
(declare-const var1169 var2740) ; Statement: r1 := @parameter0: org.apache.dubbo.config.AbstractReferenceConfig 
(assert (not (= var1169 null-var2740)))
(assert true)
;(assert (build/1692375552 (cast-from-var1848-to-var2535 var2540) (cast-from-var2740-to-var2536 var1169))) ; Statement: specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.AbstractInterfaceBuilder: void build(org.apache.dubbo.config.AbstractInterfaceConfig)>(r1) 

(declare-const var2540!1 var1848)
(declare-const var1169!1 var2740)
(define-const var233 var731 (check/1938197122 var2540!1)) ; Statement: $r2 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean check> 
 ; Statement: if $r2 == null goto $r3 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean init> 
(assert (= var233 null-var731)) ; Cond: $r2 == null 
(define-const var3060 var731 (init/1938197122 var2540!1)) ; Statement: $r3 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean init> 
 ; Statement: if $r3 == null goto $r4 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String generic> 
(assert (= var3060 null-var731)) ; Cond: $r3 == null 
(define-const var2686 String (generic/1938197122 var2540!1)) ; Statement: $r4 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String generic> 
(define-const var3526 Bool (var1656_isEmpty/-813097145 var2686)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 != 0 goto $r5 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean injvm> 
(assert (not (= (ite var3526 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1927 var731 (injvm/1938197122 var2540!1)) ; Statement: $r5 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean injvm> 
 ; Statement: if $r5 == null goto $r6 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean lazy> 
(assert (= var1927 null-var731)) ; Cond: $r5 == null 
(define-const var636 var731 (lazy/1938197122 var2540!1)) ; Statement: $r6 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean lazy> 
 ; Statement: if $r6 == null goto $r7 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String reconnect> 
(assert (= var636 null-var731)) ; Cond: $r6 == null 
(define-const var876 String (reconnect/1938197122 var2540!1)) ; Statement: $r7 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String reconnect> 
(define-const var3432 Bool (var1656_isEmpty/-813097145 var876)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7) 
 ; Statement: if $z1 != 0 goto $r8 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean sticky> 
(assert (not (= (ite var3432 1 0) 0))) ; Cond: $z1 != 0 
(define-const var3974 var731 (sticky/1938197122 var2540!1)) ; Statement: $r8 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean sticky> 
 ; Statement: if $r8 == null goto $r9 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String version> 
(assert (= var3974 null-var731)) ; Cond: $r8 == null 
(define-const var854 String (version/1938197122 var2540!1)) ; Statement: $r9 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String version> 
(define-const var855 Bool (var1656_isEmpty/-813097145 var854)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r9) 
 ; Statement: if $z2 != 0 goto $r10 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String group> 
(assert (not (= (ite var855 1 0) 0))) ; Cond: $z2 != 0 
(define-const var404 String (group/1938197122 var2540!1)) ; Statement: $r10 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String group> 
(define-const var3855 Bool (var1656_isEmpty/-813097145 var404)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r10) 
 ; Statement: if $z3 != 0 goto return 
(assert (not (= (ite var3855 1 0) 0))) ; Cond: $z3 != 0 
 ; Statement: return 
(check-sat)
; {build/1692375552=([org.apache.dubbo.config.bootstrap.builders.AbstractInterfaceBuilder, org.apache.dubbo.config.AbstractInterfaceConfig], void), cast-from-var1848-to-var2535=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], org.apache.dubbo.config.bootstrap.builders.AbstractInterfaceBuilder), cast-from-var2740-to-var2536=([org.apache.dubbo.config.AbstractReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), check/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.Boolean), init/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.Boolean), generic/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.String), var1656_isEmpty/-813097145=([java.lang.String], boolean), injvm/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.Boolean), lazy/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.Boolean), reconnect/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.String), sticky/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.Boolean), version/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.String), group/1938197122=([org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder], java.lang.String)}
; {var1848=org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder, var2540=r0, var2740=org.apache.dubbo.config.AbstractReferenceConfig, var1169=r1, var2535=org.apache.dubbo.config.bootstrap.builders.AbstractInterfaceBuilder, var2536=org.apache.dubbo.config.AbstractInterfaceConfig, var731=java.lang.Boolean, var233=$r2, var3060=$r3, var2686=$r4, var1656=org.apache.dubbo.common.utils.StringUtils, var3526=$z0, var1927=$r5, var636=$r6, var876=$r7, var3432=$z1, var3974=$r8, var854=$r9, var855=$z2, var404=$r10, var3855=$z3}
; {org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder=var1848, r0=var2540, org.apache.dubbo.config.AbstractReferenceConfig=var2740, r1=var1169, org.apache.dubbo.config.bootstrap.builders.AbstractInterfaceBuilder=var2535, org.apache.dubbo.config.AbstractInterfaceConfig=var2536, java.lang.Boolean=var731, $r2=var233, $r3=var3060, $r4=var2686, org.apache.dubbo.common.utils.StringUtils=var1656, $z0=var3526, $r5=var1927, $r6=var636, $r7=var876, $z1=var3432, $r8=var3974, $r9=var854, $z2=var855, $r10=var404, $z3=var3855}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 4}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder;	r1 := @parameter0: org.apache.dubbo.config.AbstractReferenceConfig;	specialinvoke r0.<org.apache.dubbo.config.bootstrap.builders.AbstractInterfaceBuilder: void build(org.apache.dubbo.config.AbstractInterfaceConfig)>(r1);	$r2 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean check>;	if $r2 == null goto $r3 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean init>;	$r3 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean init>;	if $r3 == null goto $r4 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String generic>;	$r4 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String generic>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 != 0 goto $r5 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean injvm>;	$r5 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean injvm>;	if $r5 == null goto $r6 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean lazy>;	$r6 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean lazy>;	if $r6 == null goto $r7 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String reconnect>;	$r7 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String reconnect>;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r7);	if $z1 != 0 goto $r8 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean sticky>;	$r8 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.Boolean sticky>;	if $r8 == null goto $r9 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String version>;	$r9 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String version>;	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r9);	if $z2 != 0 goto $r10 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String group>;	$r10 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractReferenceBuilder: java.lang.String group>;	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r10);	if $z3 != 0 goto return;	return
;block_num 10