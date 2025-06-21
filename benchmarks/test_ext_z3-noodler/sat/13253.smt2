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

(declare-sort var2056 0)
(declare-sort var3975 0)
(declare-sort var1652 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1652_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2056 var2056)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var1271 var2056) ; Statement: r1 := @this: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec 
(assert (not (= var1271 null-var2056)))
(declare-const var1770 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1770 null-String)))
(declare-const var1773 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var1773 null-ClassObject)))
(define-const var362 Bool (var1652_isBlank/-523695098 (cast-from-String-to-String var1770))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>() 
(assert (not (= (ite var362 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {var1652_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2056=org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, var1271=r1, var1770=r0, var3975=null_type, var1773=r2, var1652=org.apache.dubbo.common.utils.StringUtils, var362=$z0}
; {org.apache.dubbo.spring.security.jackson.ObjectMapperCodec=var2056, r1=var1271, r0=var1770, null_type=var3975, r2=var1773, org.apache.dubbo.common.utils.StringUtils=var1652, $z0=var362}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>();	return null
;block_num 2