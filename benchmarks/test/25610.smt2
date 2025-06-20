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

(declare-sort var343 0)
(declare-sort var1741 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var343 var343)
(declare-const null-String String)
(declare-const var3705 var343) ; Statement: r10 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var3705 null-var343)))
(declare-const var3743 String) ; Statement: r11 := @parameter0: java.lang.String 
(assert (not (= var3743 null-String)))
(declare-const var2096 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2096 null-String)))
(declare-const var2147 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var2147 null-String)))
 ; Statement: if r11 != null goto (branch) 
(assert (not (= var3743 null-String))) ; Cond: r11 != null 
 ; Statement: if r0 == null goto (branch) 
(assert (= var2096 null-String)) ; Cond: r0 == null 
 ; Statement: if r1 != null goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= var2147 null-String)))) ; Negate: Cond: r1 != null  
(define-const var1608 String var3743) ; Statement: $r12 = r11 
 ; Statement: goto [?= return $r12] 
(assert true) ; Non Conditional
 ; Statement: return $r12 
(check-sat)
; {}
; {var343=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var3705=r10, var3743=r11, var1741=null_type, var2096=r0, var2147=r1, var1608=$r12}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var343, r10=var3705, r11=var3743, null_type=var1741, r0=var2096, r1=var2147, $r12=var1608}
;seq 
;cnt {}
;stmts r10 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r11 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	if r11 != null goto (branch);	if r0 == null goto (branch);	if r1 != null goto $r2 = new java.lang.StringBuilder;	$r12 = r11;	goto [?= return $r12];	return $r12
;block_num 5