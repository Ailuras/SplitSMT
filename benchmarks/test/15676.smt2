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

(declare-sort var1402 0)
(declare-sort var3739 0)
(declare-sort var1226 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1226_isEmpty/-813097145 (String) Bool)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1402 var1402)
(declare-const null-String String)
(declare-const var3561 var1402) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper 
(assert (not (= var3561 null-var1402)))
(declare-const var1110 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1110 null-String)))
(define-const var3614 Bool (var1226_isEmpty/-813097145 var1110)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___") 
(assert (= (ite var3614 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2621 String (replace/2138489945 var1110 (cast-from-String-to-String "$") (cast-from-String-to-String "___"))) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___") 
 ; Statement: return $r1 
(check-sat)
; {var1226_isEmpty/-813097145=([java.lang.String], boolean), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1402=org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper, var3561=r2, var1110=r0, var3739=null_type, var1226=org.apache.dubbo.common.utils.StringUtils, var3614=$z0, var2621=$r1}
; {org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper=var1402, r2=var3561, r0=var1110, null_type=var3739, org.apache.dubbo.common.utils.StringUtils=var1226, $z0=var3614, $r1=var2621}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___");	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___");	return $r1
;block_num 2