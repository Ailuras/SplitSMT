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

(declare-sort var2163 0)
(declare-sort var2876 0)
(declare-sort var2418 0)
(declare-sort var3793 0)
(declare-sort var2806 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2876_getSystemProperty/1393069448 (String) String)
(declare-fun var2418_isEmpty/-813097145 (String) Bool)
(declare-fun var2806_loadProperties/1231968541 (var2163 String Bool Bool) var3793)
(declare-const null-var2163 var2163)
(declare-const var1226 var2163) ; Statement: r0 := @parameter0: java.util.Set 
(assert (not (= var1226 null-var2163)))
(define-const var3743 String (var2876_getSystemProperty/1393069448 "dubbo.properties.file")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.properties.file") 
(define-const var3223 Bool (var2418_isEmpty/-813097145 var3743)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.util.Properties loadProperties(java.util.Set,java.lang.String,boolean,boolean)>(r0, r1, 0, 1) 
(assert (= (ite var3223 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3903 var3793 (var2806_loadProperties/1231968541 var1226 var3743 (ite (= 1 0) true false) (ite (= 1 1) true false))) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.util.Properties loadProperties(java.util.Set,java.lang.String,boolean,boolean)>(r0, r1, 0, 1) 
 ; Statement: return $r2 
(check-sat)
; {var2876_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var2418_isEmpty/-813097145=([java.lang.String], boolean), var2806_loadProperties/1231968541=([java.util.Set, java.lang.String, boolean, boolean], java.util.Properties)}
; {var2163=java.util.Set, var1226=r0, var2876=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3743=r1, var2418=org.apache.dubbo.common.utils.StringUtils, var3223=$z0, var3793=java.util.Properties, var2806=org.apache.dubbo.common.utils.ConfigUtils, var3903=$r2}
; {java.util.Set=var2163, r0=var1226, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var2876, r1=var3743, org.apache.dubbo.common.utils.StringUtils=var2418, $z0=var3223, java.util.Properties=var3793, org.apache.dubbo.common.utils.ConfigUtils=var2806, $r2=var3903}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Set;	r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.properties.file");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.util.Properties loadProperties(java.util.Set,java.lang.String,boolean,boolean)>(r0, r1, 0, 1);	$r2 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.util.Properties loadProperties(java.util.Set,java.lang.String,boolean,boolean)>(r0, r1, 0, 1);	return $r2
;block_num 2