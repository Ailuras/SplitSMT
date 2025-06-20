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

(declare-sort var3593 0)
(declare-sort var1609 0)
(declare-sort var3455 0)
(declare-sort var3565 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3593 String) String)
(declare-fun var1609_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1609_splitToList/858263979 (String Int) var3455)
(declare-fun var3565_unmodifiableList/-1798737475 (var3455) var3455)
(declare-const null-var3593 var3593)
(declare-const var2265 var3593) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2265 null-var3593)))
(assert true)
(define-const var1829 String (getParameter/-1307325648 var2265 "prefer.serialization")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("prefer.serialization") 
(define-const var3152 Bool (var1609_isNotBlank/-358081771 (cast-from-String-to-String var1829))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
(assert (not (= (ite var3152 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1405 var3455 (var1609_splitToList/858263979 var1829 44)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r1, 44) 
(define-const var2538 var3455 (var3565_unmodifiableList/-1798737475 var1405)) ; Statement: $r4 = staticinvoke <java.util.Collections: java.util.List unmodifiableList(java.util.List)>($r3) 
 ; Statement: return $r4 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1609_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1609_splitToList/858263979=([java.lang.String, char], java.util.List), var3565_unmodifiableList/-1798737475=([java.util.List], java.util.List)}
; {var3593=org.apache.dubbo.common.URL, var2265=r0, var1829=r1, var1609=org.apache.dubbo.common.utils.StringUtils, var3152=$z0, var3455=java.util.List, var1405=$r3, var3565=java.util.Collections, var2538=$r4}
; {org.apache.dubbo.common.URL=var3593, r0=var2265, r1=var1829, org.apache.dubbo.common.utils.StringUtils=var1609, $z0=var3152, java.util.List=var3455, $r3=var1405, java.util.Collections=var3565, $r4=var2538}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("prefer.serialization");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r2 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	$r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r1, 44);	$r4 = staticinvoke <java.util.Collections: java.util.List unmodifiableList(java.util.List)>($r3);	return $r4
;block_num 2