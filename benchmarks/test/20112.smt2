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

(declare-sort var283 0)
(declare-sort var1266 0)
(declare-sort var3641 0)
(declare-sort var1598 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceKey/1456125852 (var1266) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1598_isNotEmptyMap/1884409606 (var283) Bool)
(declare-const null-var283 var283)
(declare-const null-var1266 var1266)
(declare-const null-var3641 var3641)
(declare-const var3752 var283) ; Statement: r2 := @parameter0: java.util.Map 
(assert (not (= var3752 null-var283)))
(declare-const var2224 var1266) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2224 null-var1266)))
(define-const var892 var3641 null-var3641) ; Statement: r11 = null 
(assert true)
(define-const var3653 String (getServiceKey/1456125852 var2224)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var362 Bool (contains/1009244746 var3653 (cast-from-String-to-String "*"))) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>("*") 
 ; Statement: if $z0 != 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r2) 
(assert (not (= (ite var362 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2580 Bool (var1598_isNotEmptyMap/1884409606 var3752)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r2) 
 ; Statement: if $z1 == 0 goto return r11 
(assert (= (ite var2580 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r11 
(check-sat)
; {getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1598_isNotEmptyMap/1884409606=([java.util.Map], boolean)}
; {var283=java.util.Map, var3752=r2, var1266=org.apache.dubbo.common.URL, var2224=r0, var3641=org.apache.dubbo.rpc.Exporter, var892=r11, var3653=$r1, var362=$z0, var1598=org.apache.dubbo.common.utils.CollectionUtils, var2580=$z1}
; {java.util.Map=var283, r2=var3752, org.apache.dubbo.common.URL=var1266, r0=var2224, org.apache.dubbo.rpc.Exporter=var3641, r11=var892, $r1=var3653, $z0=var362, org.apache.dubbo.common.utils.CollectionUtils=var1598, $z1=var2580}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r2 := @parameter0: java.util.Map;	r0 := @parameter1: org.apache.dubbo.common.URL;	r11 = null;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>("*");	if $z0 != 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r2);	if $z1 == 0 goto return r11;	return r11
;block_num 3