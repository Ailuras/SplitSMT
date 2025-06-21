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

(declare-sort var1256 0)
(declare-sort var1281 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1281_replace/-1206725732 (String String String Int) String)
(declare-const null-String String)
(declare-const var3057 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3057 null-String)))
(declare-const var99 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var99 null-String)))
(declare-const var772 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var772 null-String)))
(define-const var843 Int (cast-from-Int-to-Int -1)) ; Statement: $i1 = (int) -1 
(define-const var3694 String (var1281_replace/-1206725732 var3057 var99 var772 var843)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String,int)>(r0, r1, r2, $i1) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([int], int), var1281_replace/-1206725732=([java.lang.String, java.lang.String, java.lang.String, int], java.lang.String)}
; {var3057=r0, var1256=null_type, var99=r1, var772=r2, var843=$i1, var1281=org.apache.dubbo.common.utils.StringUtils, var3694=$r3}
; {r0=var3057, null_type=var1256, r1=var99, r2=var772, $i1=var843, org.apache.dubbo.common.utils.StringUtils=var1281, $r3=var3694}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String,int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$i1 = (int) -1;	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String,int)>(r0, r1, r2, $i1);	return $r3
;block_num 1