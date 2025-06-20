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

(declare-sort var2664 0)
(declare-sort var1749 0)
(declare-sort var1866 0)
(declare-sort var2100 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1866_getFormatter/5978766 (String) var1749)
(declare-fun var1866_parse/-547256779 (String var1749) var2100)
(declare-const null-String String)
(declare-const var1188 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1188 null-String)))
(declare-const var1394 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1394 null-String)))
(define-const var422 String "yyyy-MM-dd HH:mm:ss") ; Statement: $r1 = "yyyy-MM-dd HH:mm:ss" 
(assert true)
(define-const var3936 Bool (= var422 var1394)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0) 
(assert (= (ite var3936 1 0) 0)) ; Cond: $z0 == 0 
(define-const var212 var1749 (var1866_getFormatter/5978766 var1394)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0) 
(define-const var221 var2100 (var1866_parse/-547256779 var1188 var212)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.util.Date parse(java.lang.String,java.time.format.DateTimeFormatter)>(r3, r2) 
 ; Statement: return $r4 
(check-sat)
; {var1866_getFormatter/5978766=([java.lang.String], java.time.format.DateTimeFormatter), var1866_parse/-547256779=([java.lang.String, java.time.format.DateTimeFormatter], java.util.Date)}
; {var1188=r3, var2664=null_type, var1394=r0, var422=$r1, var3936=$z0, var1749=java.time.format.DateTimeFormatter, var1866=org.apache.dubbo.common.utils.DateUtils, var212=r2, var2100=java.util.Date, var221=$r4}
; {r3=var1188, null_type=var2664, r0=var1394, $r1=var422, $z0=var3936, java.time.format.DateTimeFormatter=var1749, org.apache.dubbo.common.utils.DateUtils=var1866, r2=var212, java.util.Date=var2100, $r4=var221}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = "yyyy-MM-dd HH:mm:ss";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0);	r2 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.time.format.DateTimeFormatter getFormatter(java.lang.String)>(r0);	$r4 = staticinvoke <org.apache.dubbo.common.utils.DateUtils: java.util.Date parse(java.lang.String,java.time.format.DateTimeFormatter)>(r3, r2);	return $r4
;block_num 2