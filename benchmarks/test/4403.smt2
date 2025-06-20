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

(declare-sort var765 0)
(declare-sort var3439 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3439_repeat/1008746495 (String Int) String)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3206 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3206 null-String)))
(declare-const var2689 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2689 null-String)))
(declare-const var3557 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var3557 null-Int)))
 ; Statement: if r0 == null goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(r0, i0) 
(assert (= var3206 null-String)) ; Cond: r0 == null 
(define-const var600 String (var3439_repeat/1008746495 var3206 var3557)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(r0, i0) 
 ; Statement: return $r1 
(check-sat)
; {var3439_repeat/1008746495=([java.lang.String, int], java.lang.String)}
; {var3206=r0, var765=null_type, var2689=r2, var3557=i0, var3439=org.apache.dubbo.common.utils.StringUtils, var600=$r1}
; {r0=var3206, null_type=var765, r2=var2689, i0=var3557, org.apache.dubbo.common.utils.StringUtils=var3439, $r1=var600}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	i0 := @parameter2: int;	if r0 == null goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(r0, i0);	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(r0, i0);	return $r1
;block_num 2