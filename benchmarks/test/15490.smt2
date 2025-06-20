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

(declare-sort var3920 0)
(declare-sort var738 0)
(declare-sort var348 0)
(declare-sort var1901 0)
(declare-sort var3246 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var738 String) String)
(declare-fun var3246_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3920 var3920)
(declare-const null-var738 var738)
(declare-const null-var348 var348)
(declare-const null-String String)
(declare-const var2538 var3920) ; Statement: r5 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var2538 null-var3920)))
(declare-const var814 var738) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var814 null-var738)))
(declare-const var3537 var348) ; Statement: r4 := @parameter1: java.util.Properties 
(assert (not (= var3537 null-var348)))
(declare-const var725 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var725 null-String)))
(declare-const var3927 String) ; Statement: r3 := @parameter3: java.lang.String 
(assert (not (= var3927 null-String)))
(assert true)
(define-const var83 String (getParameter/-1307325648 var814 var725)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var843 Bool (var3246_isNotEmpty/-1251449450 var83)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
(assert (= (ite var843 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3810 Bool (var3246_isNotEmpty/-1251449450 var3927)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var3810 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3246_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3920=org.apache.dubbo.registry.nacos.NacosConnectionManager, var2538=r5, var738=org.apache.dubbo.common.URL, var814=r0, var348=java.util.Properties, var3537=r4, var725=r1, var1901=null_type, var3927=r3, var83=r2, var3246=org.apache.dubbo.common.utils.StringUtils, var843=$z0, var3810=$z1}
; {org.apache.dubbo.registry.nacos.NacosConnectionManager=var3920, r5=var2538, org.apache.dubbo.common.URL=var738, r0=var814, java.util.Properties=var348, r4=var3537, r1=var725, null_type=var1901, r3=var3927, r2=var83, org.apache.dubbo.common.utils.StringUtils=var3246, $z0=var843, $z1=var3810}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2}
;stmts r5 := @this: org.apache.dubbo.registry.nacos.NacosConnectionManager;	r0 := @parameter0: org.apache.dubbo.common.URL;	r4 := @parameter1: java.util.Properties;	r1 := @parameter2: java.lang.String;	r3 := @parameter3: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z1 == 0 goto return;	return
;block_num 3