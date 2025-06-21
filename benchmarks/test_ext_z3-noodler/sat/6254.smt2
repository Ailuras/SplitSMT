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

(declare-sort var2663 0)
(declare-sort var3826 0)
(declare-sort var2587 0)
(declare-sort var1912 0)
(declare-sort var1205 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun interfaceName/2049477907 (var3826) String)
(declare-fun cast-from-var2663-to-var3826 (var2663) var3826)
(declare-fun var2587_getProperty/258823597 (String) String)
(declare-fun var1205_isEmpty/-813097145 (String) Bool)
(declare-fun var1205_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2663 var2663)
(declare-const null-String String)
(declare-const var3065 var2663) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var3065 null-var2663)))
(define-const var423 String (interfaceName/2049477907 (cast-from-var2663-to-var3826 var3065))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName> 
(define-const var2057 String (var2587_getProperty/258823597 var423)) ; Statement: r40 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String)>($r1) 
(define-const var34 String null-String) ; Statement: r41 = null 
(define-const var3833 Bool (var1205_isEmpty/-813097145 var2057)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r40) 
 ; Statement: if $z0 == 0 goto $z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r40) 
(assert (= (ite var3833 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2780 Bool (var1205_isNotEmpty/-1251449450 var2057)) ; Statement: $z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r40) 
 ; Statement: if $z4 == 0 goto return 
(assert (= (ite var2780 1 0) 0)) ; Cond: $z4 == 0 
 ; Statement: return 
(check-sat)
; {interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var2663-to-var3826=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), var2587_getProperty/258823597=([java.lang.String], java.lang.String), var1205_isEmpty/-813097145=([java.lang.String], boolean), var1205_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2663=org.apache.dubbo.config.ReferenceConfigBase, var3065=r0, var3826=org.apache.dubbo.config.AbstractInterfaceConfig, var423=$r1, var2587=java.lang.System, var2057=r40, var1912=null_type, var34=r41, var1205=org.apache.dubbo.common.utils.StringUtils, var3833=$z0, var2780=$z4}
; {org.apache.dubbo.config.ReferenceConfigBase=var2663, r0=var3065, org.apache.dubbo.config.AbstractInterfaceConfig=var3826, $r1=var423, java.lang.System=var2587, r40=var2057, null_type=var1912, r41=var34, org.apache.dubbo.common.utils.StringUtils=var1205, $z0=var3833, $z4=var2780}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String interfaceName>;	r40 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String)>($r1);	r41 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r40);	if $z0 == 0 goto $z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r40);	$z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r40);	if $z4 == 0 goto return;	return
;block_num 3