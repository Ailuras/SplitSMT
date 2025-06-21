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

(declare-sort var2294 0)
(declare-sort var3934 0)
(declare-sort var1264 0)
(declare-sort var1303 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1303_getFormatter/5978766 (String) var1264)
(declare-fun var1303_format/1757868183 (var2294 var1264) String)
(declare-const null-var2294 var2294)
(declare-const null-String String)
(declare-const var268 var2294) ; Statement: r3 := @parameter0: java.util.Date 
(assert (not (= var268 null-var2294)))
(declare-const var2402 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2402 null-String)))
(define-const var143 String "yyyy-MM-dd HH:mm:ss") ; Statement: $r1 = "yyyy-MM-dd HH:mm:ss" 
(assert true)
(define-const var2715 Bool (= var143 var2402)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0) 
(assert (= (ite var2715 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3989 var1264 (var1303_getFormatter/5978766 var2402)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0) 
(define-const var2 String (var1303_format/1757868183 var268 var3989)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.lang.String format(java.util.Date,java.time.format.DateTimeFormatter)>(r3, r2) 
 ; Statement: return $r4 
(check-sat)
; {var1303_getFormatter/5978766=([java.lang.String], java.time.format.DateTimeFormatter), var1303_format/1757868183=([java.util.Date, java.time.format.DateTimeFormatter], java.lang.String)}
; {var2294=java.util.Date, var268=r3, var2402=r0, var3934=null_type, var143=$r1, var2715=$z0, var1264=java.time.format.DateTimeFormatter, var1303=org.apache.dubbo.common.utils.DateUtils, var3989=r2, var2=$r4}
; {java.util.Date=var2294, r3=var268, r0=var2402, null_type=var3934, $r1=var143, $z0=var2715, java.time.format.DateTimeFormatter=var1264, org.apache.dubbo.common.utils.DateUtils=var1303, r2=var3989, $r4=var2}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @parameter0: java.util.Date;	r0 := @parameter1: java.lang.String;	$r1 = "yyyy-MM-dd HH:mm:ss";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0);	r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0);	$r4 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.lang.String format(java.util.Date,java.time.format.DateTimeFormatter)>(r3, r2);	return $r4
;block_num 2