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

(declare-sort var319 0)
(declare-sort var317 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var317_base642bytes/1057468428 (String Int Int) (Array Int Int))
(declare-const null-String String)
(declare-const var2814 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2814 null-String)))
(assert true)
(define-const var2123 Int (length/-134980193 var2814)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2380 (Array Int Int) (var317_base642bytes/1057468428 var2814 0 var2123)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] base642bytes(java.lang.String,int,int)>(r0, 0, $i0) 
 ; Statement: return $r1 
(check-sat)
; {length/-134980193=([java.lang.String], int), var317_base642bytes/1057468428=([java.lang.String, int, int], byte[])}
; {var2814=r0, var319=null_type, var2123=$i0, var317=org.apache.dubbo.common.io.Bytes, var2380=$r1}
; {r0=var2814, null_type=var319, $i0=var2123, org.apache.dubbo.common.io.Bytes=var317, $r1=var2380}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$r1 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] base642bytes(java.lang.String,int,int)>(r0, 0, $i0);	return $r1
;block_num 1