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

(declare-sort var686 0)
(declare-sort var576 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var576_hex2bytes/358044712 (String Int Int) (Array Int Int))
(declare-const null-String String)
(declare-const var1372 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1372 null-String)))
(assert true)
(define-const var1785 Int (length/-134980193 var1372)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2935 (Array Int Int) (var576_hex2bytes/358044712 var1372 0 var1785)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] hex2bytes(java.lang.String,int,int)>(r0, 0, $i0) 
 ; Statement: return $r1 
(check-sat)
; {length/-134980193=([java.lang.String], int), var576_hex2bytes/358044712=([java.lang.String, int, int], byte[])}
; {var1372=r0, var686=null_type, var1785=$i0, var576=org.apache.dubbo.common.io.Bytes, var2935=$r1}
; {r0=var1372, null_type=var686, $i0=var1785, org.apache.dubbo.common.io.Bytes=var576, $r1=var2935}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$r1 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] hex2bytes(java.lang.String,int,int)>(r0, 0, $i0);	return $r1
;block_num 1