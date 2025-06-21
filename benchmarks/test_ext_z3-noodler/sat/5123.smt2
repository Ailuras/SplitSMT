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

(declare-sort var2429 0)
(declare-sort var2316 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/1068683673 (String) (Array Int Int))
(declare-fun var2316_getMD5/1994852715 ((Array Int Int)) (Array Int Int))
(declare-const null-String String)
(declare-const var1406 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1406 null-String)))
(assert true)
(define-const var2980 (Array Int Int) (getBytes/1068683673 var1406)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>() 
(define-const var2211 (Array Int Int) (var2316_getMD5/1994852715 var2980)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] getMD5(byte[])>($r1) 
 ; Statement: return $r2 
(check-sat)
; {getBytes/1068683673=([java.lang.String], byte[]), var2316_getMD5/1994852715=([byte[]], byte[])}
; {var1406=r0, var2429=null_type, var2980=$r1, var2316=org.apache.dubbo.common.io.Bytes, var2211=$r2}
; {r0=var1406, null_type=var2429, $r1=var2980, org.apache.dubbo.common.io.Bytes=var2316, $r2=var2211}
;seq <java.lang.String: byte[] getBytes()>
;cnt {"<java.lang.String: byte[] getBytes()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>();	$r2 = staticinvoke <org.apache.dubbo.common.io.Bytes: byte[] getMD5(byte[])>($r1);	return $r2
;block_num 1