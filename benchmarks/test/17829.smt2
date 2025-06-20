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

(declare-sort var3358 0)
(declare-sort var3725 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var3358 var3358)
(declare-const null-String String)
(declare-const var3665 var3358) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.message.codec.PlainTextCodecFactory 
(assert (not (= var3665 null-var3358)))
(declare-const var2461 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2461 null-String)))
(assert true)
(define-const var3579 Bool (startsWith/-1785782452 var2461 "text/")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("text/") 
 ; Statement: return $z0 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var3358=org.apache.dubbo.remoting.http12.message.codec.PlainTextCodecFactory, var3665=r1, var2461=r0, var3725=null_type, var3579=$z0}
; {org.apache.dubbo.remoting.http12.message.codec.PlainTextCodecFactory=var3358, r1=var3665, r0=var2461, null_type=var3725, $z0=var3579}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.message.codec.PlainTextCodecFactory;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("text/");	return $z0
;block_num 1