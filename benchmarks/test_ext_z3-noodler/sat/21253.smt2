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

(declare-sort var1801 0)
(declare-sort var780 0)
(declare-sort var2283 0)
(declare-sort var1848 0)
(declare-sort var668 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var780_getDefaultInstance/370322771 () var780)
(declare-fun getSubject/-1434742054 (var780) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-fun getDescription/-1123814006 (var780) String)
(declare-fun getUnknownFields/94315221 (var1848) var2283)
(declare-fun cast-from-var780-to-var1848 (var780) var1848)
(declare-fun mergeUnknownFields/1420396633 (var1801 var2283) var1801)
(declare-fun onChanged/-1484518325 (var668) void)
(declare-fun cast-from-var1801-to-var668 (var1801) var668)
(declare-const null-var1801 var1801)
(declare-const null-var780 var780)
(declare-const var3255 var1801) ; Statement: r4 := @this: com.google.rpc.QuotaFailure$Violation$Builder 
(assert (not (= var3255 null-var1801)))
(declare-const var1629 var780) ; Statement: r0 := @parameter0: com.google.rpc.QuotaFailure$Violation 
(assert (not (= var1629 null-var780)))
(define-const var3485 var780 var780_getDefaultInstance/370322771) ; Statement: $r1 = staticinvoke <com.google.rpc.QuotaFailure$Violation: com.google.rpc.QuotaFailure$Violation getDefaultInstance()>() 
 ; Statement: if r0 != $r1 goto $r2 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getSubject()>() 
(assert (not (= var1629 var3485))) ; Cond: r0 != $r1 
(assert true)
(define-const var629 String (getSubject/-1434742054 var1629)) ; Statement: $r2 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getSubject()>() 
(assert true)
(define-const var712 Bool (isEmpty/-1285796103 var629)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $r3 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getDescription()>() 
(assert (not (= (ite var712 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var2304 String (getDescription/-1123814006 var1629)) ; Statement: $r3 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getDescription()>() 
(assert true)
(define-const var3634 Bool (isEmpty/-1285796103 var2304)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z1 != 0 goto $r5 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert (not (= (ite var3634 1 0) 0))) ; Cond: $z1 != 0 
(assert true)
(define-const var2218 var2283 (getUnknownFields/94315221 (cast-from-var780-to-var1848 var1629))) ; Statement: $r5 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert true)
;(assert (mergeUnknownFields/1420396633 var3255 var2218)) ; Statement: virtualinvoke r4.<com.google.rpc.QuotaFailure$Violation$Builder: com.google.rpc.QuotaFailure$Violation$Builder mergeUnknownFields(com.google.protobuf.UnknownFieldSet)>($r5) 

(declare-const var3255!1 var1801)
(declare-const var2218!1 var2283)
(assert true)
;(assert (onChanged/-1484518325 (cast-from-var1801-to-var668 var3255!1))) ; Statement: virtualinvoke r4.<com.google.rpc.QuotaFailure$Violation$Builder: void onChanged()>() 

(declare-const var3255!2 var1801)
 ; Statement: return r4 
(check-sat)
; {var780_getDefaultInstance/370322771=([], com.google.rpc.QuotaFailure$Violation), getSubject/-1434742054=([com.google.rpc.QuotaFailure$Violation], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean), getDescription/-1123814006=([com.google.rpc.QuotaFailure$Violation], java.lang.String), getUnknownFields/94315221=([com.google.protobuf.GeneratedMessageV3], com.google.protobuf.UnknownFieldSet), cast-from-var780-to-var1848=([com.google.rpc.QuotaFailure$Violation], com.google.protobuf.GeneratedMessageV3), mergeUnknownFields/1420396633=([com.google.rpc.QuotaFailure$Violation$Builder, com.google.protobuf.UnknownFieldSet], com.google.rpc.QuotaFailure$Violation$Builder), onChanged/-1484518325=([com.google.protobuf.GeneratedMessageV3$Builder], void), cast-from-var1801-to-var668=([com.google.rpc.QuotaFailure$Violation$Builder], com.google.protobuf.GeneratedMessageV3$Builder)}
; {var1801=com.google.rpc.QuotaFailure$Violation$Builder, var3255=r4, var780=com.google.rpc.QuotaFailure$Violation, var1629=r0, var3485=$r1, var629=$r2, var712=$z0, var2304=$r3, var3634=$z1, var2283=com.google.protobuf.UnknownFieldSet, var1848=com.google.protobuf.GeneratedMessageV3, var2218=$r5, var668=com.google.protobuf.GeneratedMessageV3$Builder}
; {com.google.rpc.QuotaFailure$Violation$Builder=var1801, r4=var3255, com.google.rpc.QuotaFailure$Violation=var780, r0=var1629, $r1=var3485, $r2=var629, $z0=var712, $r3=var2304, $z1=var3634, com.google.protobuf.UnknownFieldSet=var2283, com.google.protobuf.GeneratedMessageV3=var1848, $r5=var2218, com.google.protobuf.GeneratedMessageV3$Builder=var668}
;seq <java.lang.String: boolean isEmpty()>;	<java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 2}
;stmts r4 := @this: com.google.rpc.QuotaFailure$Violation$Builder;	r0 := @parameter0: com.google.rpc.QuotaFailure$Violation;	$r1 = staticinvoke <com.google.rpc.QuotaFailure$Violation: com.google.rpc.QuotaFailure$Violation getDefaultInstance()>();	if r0 != $r1 goto $r2 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getSubject()>();	$r2 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getSubject()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean isEmpty()>();	if $z0 != 0 goto $r3 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getDescription()>();	$r3 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: java.lang.String getDescription()>();	$z1 = virtualinvoke $r3.<java.lang.String: boolean isEmpty()>();	if $z1 != 0 goto $r5 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	$r5 = virtualinvoke r0.<com.google.rpc.QuotaFailure$Violation: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	virtualinvoke r4.<com.google.rpc.QuotaFailure$Violation$Builder: com.google.rpc.QuotaFailure$Violation$Builder mergeUnknownFields(com.google.protobuf.UnknownFieldSet)>($r5);	virtualinvoke r4.<com.google.rpc.QuotaFailure$Violation$Builder: void onChanged()>();	return r4
;block_num 4