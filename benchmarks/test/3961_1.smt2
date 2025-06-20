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

(declare-sort var2441 0)
(declare-sort var3982 0)
(declare-sort var2322 0)
(declare-sort var613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var613_format/1757868183 (var2441 var2322) String)
(declare-const null-var2441 var2441)
(declare-const null-String String)
(declare-const var613-DATE_TIME_FORMAT var2322)
(declare-const var1721 var2441) ; Statement: r3 := @parameter0: java.util.Date 
(assert (not (= var1721 null-var2441)))
(declare-const var276 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var276 null-String)))
(define-const var3051 String "yyyy-MM-dd HH:mm:ss") ; Statement: $r1 = "yyyy-MM-dd HH:mm:ss" 
(assert true)
(define-const var3792 Bool (= var3051 var276)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0) 
(assert (not (= (ite var3792 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var250 var2322 var613-DATE_TIME_FORMAT) ; Statement: $r5 = <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter DATE_TIME_FORMAT> 
(define-const var3357 String (var613_format/1757868183 var1721 var250)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.lang.String format(java.util.Date,java.time.format.DateTimeFormatter)>(r3, $r5) 
 ; Statement: return $r6 
(check-sat)
; {var613_format/1757868183=([java.util.Date, java.time.format.DateTimeFormatter], java.lang.String)}
; {var2441=java.util.Date, var1721=r3, var276=r0, var3982=null_type, var3051=$r1, var3792=$z0, var2322=java.time.format.DateTimeFormatter, var613=org.apache.dubbo.common.utils.DateUtils, var250=$r5, var3357=$r6}
; {java.util.Date=var2441, r3=var1721, r0=var276, null_type=var3982, $r1=var3051, $z0=var3792, java.time.format.DateTimeFormatter=var2322, org.apache.dubbo.common.utils.DateUtils=var613, $r5=var250, $r6=var3357}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @parameter0: java.util.Date;	r0 := @parameter1: java.lang.String;	$r1 = "yyyy-MM-dd HH:mm:ss";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0);	$r5 = <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter DATE_TIME_FORMAT>;	$r6 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.lang.String format(java.util.Date,java.time.format.DateTimeFormatter)>(r3, $r5);	return $r6
;block_num 2