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

(declare-sort var3247 0)
(declare-sort var2550 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2550_base642bytes/-1302818334 (String Int Int (Array Int Int)) (Array Int Int))
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var2646 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2646 null-String)))
(declare-const var2025 (Array Int Int)) ; Statement: r1 := @parameter1: char[] 
(assert (not (= var2025 null-__Array__Int__Int__)))
(assert true)
(define-const var2616 Int (length/-134980193 var2646)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2579 (Array Int Int) (var2550_base642bytes/-1302818334 var2646 0 var2616 var2025)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] base642bytes(java.lang.String,int,int,char[])>(r0, 0, $i0, r1) 
 ; Statement: return $r2 
(check-sat)
; {length/-134980193=([java.lang.String], int), var2550_base642bytes/-1302818334=([java.lang.String, int, int, char[]], byte[])}
; {var2646=r0, var3247=null_type, var2025=r1, var2616=$i0, var2550=org.apache.dubbo.common.io.Bytes, var2579=$r2}
; {r0=var2646, null_type=var3247, r1=var2025, $i0=var2616, org.apache.dubbo.common.io.Bytes=var2550, $r2=var2579}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: char[];	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$r2 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] base642bytes(java.lang.String,int,int,char[])>(r0, 0, $i0, r1);	return $r2
;block_num 1