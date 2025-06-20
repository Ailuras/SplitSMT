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

(declare-sort var3199 0)
(declare-sort var780 0)
(declare-sort var1564 0)
(declare-sort var1020 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1564_parse/-547256779 (String var780) var1020)
(declare-const null-String String)
(declare-const var1564-DATE_TIME_FORMAT var780)
(declare-const var2894 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2894 null-String)))
(declare-const var627 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var627 null-String)))
(define-const var2419 String "yyyy-MM-dd HH:mm:ss") ; Statement: $r1 = "yyyy-MM-dd HH:mm:ss" 
(assert true)
(define-const var1350 Bool (= var2419 var627)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0) 
(assert (not (= (ite var1350 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3652 var780 var1564-DATE_TIME_FORMAT) ; Statement: $r5 = <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter DATE_TIME_FORMAT> 
(define-const var3738 var1020 (var1564_parse/-547256779 var2894 var3652)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.util.Date parse(java.lang.String,java.time.format.DateTimeFormatter)>(r3, $r5) 
 ; Statement: return $r6 
(check-sat)
; {var1564_parse/-547256779=([java.lang.String, java.time.format.DateTimeFormatter], java.util.Date)}
; {var2894=r3, var3199=null_type, var627=r0, var2419=$r1, var1350=$z0, var780=java.time.format.DateTimeFormatter, var1564=org.apache.dubbo.common.utils.DateUtils, var3652=$r5, var1020=java.util.Date, var3738=$r6}
; {r3=var2894, null_type=var3199, r0=var627, $r1=var2419, $z0=var1350, java.time.format.DateTimeFormatter=var780, org.apache.dubbo.common.utils.DateUtils=var1564, $r5=var3652, java.util.Date=var1020, $r6=var3738}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = "yyyy-MM-dd HH:mm:ss";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0);	$r5 = <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter DATE_TIME_FORMAT>;	$r6 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.util.Date parse(java.lang.String,java.time.format.DateTimeFormatter)>(r3, $r5);	return $r6
;block_num 2