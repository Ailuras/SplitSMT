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

(declare-sort var1476 0)
(declare-sort var3840 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var3840_base642bytes/-1873182321 (String Int Int String) (Array Int Int))
(declare-const null-String String)
(declare-const var1998 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1998 null-String)))
(declare-const var1071 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1071 null-String)))
(assert true)
(define-const var1688 Int (length/-134980193 var1998)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2937 (Array Int Int) (var3840_base642bytes/-1873182321 var1998 0 var1688 var1071)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] base642bytes(java.lang.String,int,int,java.lang.String)>(r0, 0, $i0, r1) 
 ; Statement: return $r2 
(check-sat)
; {length/-134980193=([java.lang.String], int), var3840_base642bytes/-1873182321=([java.lang.String, int, int, java.lang.String], byte[])}
; {var1998=r0, var1476=null_type, var1071=r1, var1688=$i0, var3840=org.apache.dubbo.common.io.Bytes, var2937=$r2}
; {r0=var1998, null_type=var1476, r1=var1071, $i0=var1688, org.apache.dubbo.common.io.Bytes=var3840, $r2=var2937}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$r2 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] base642bytes(java.lang.String,int,int,java.lang.String)>(r0, 0, $i0, r1);	return $r2
;block_num 1