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

(declare-sort var3441 0)
(declare-sort var3845 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceInterface/-1311863806 (var3441) String)
(declare-fun getCategory/-59794707 (var3441 String) String)
(declare-fun var3845_isMatchCategory/269972156 (String String) Bool)
(declare-const null-var3441 var3441)
(declare-const var866 var3441) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var866 null-var3441)))
(declare-const var1679 var3441) ; Statement: r2 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1679 null-var3441)))
(assert true)
(define-const var800 String (getServiceInterface/-1311863806 var866)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var1623 String (getServiceInterface/-1311863806 var1679)) ; Statement: r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var2632 String "*") ; Statement: $r4 = "*" 
(assert true)
(define-const var544 Bool (= var2632 var800)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto $r17 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers") 
(assert (not (= (ite var544 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var2330 String (getCategory/-59794707 var1679 "providers")) ; Statement: $r17 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers") 
(assert true)
(define-const var1730 String (getCategory/-59794707 var866 "providers")) ; Statement: $r18 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers") 
(define-const var3642 Bool (var3845_isMatchCategory/269972156 var2330 var1730)) ; Statement: $z14 = staticinvoke <org.apache.dubbo.common.utils.UrlUtils: boolean isMatchCategory(java.lang.String,java.lang.String)>($r17, $r18) 
 ; Statement: if $z14 != 0 goto $z1 = virtualinvoke r2.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("enabled", 1) 
(assert (not (not (= (ite var3642 1 0) 0)))) ; Negate: Cond: $z14 != 0  
 ; Statement: return 0 
(check-sat)
; {getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), getCategory/-59794707=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3845_isMatchCategory/269972156=([java.lang.String, java.lang.String], boolean)}
; {var3441=org.apache.dubbo.common.URL, var866=r0, var1679=r2, var800=r1, var1623=r3, var2632=$r4, var544=$z0, var2330=$r17, var1730=$r18, var3845=org.apache.dubbo.common.utils.UrlUtils, var3642=$z14}
; {org.apache.dubbo.common.URL=var3441, r0=var866, r2=var1679, r1=var800, r3=var1623, $r4=var2632, $z0=var544, $r17=var2330, $r18=var1730, org.apache.dubbo.common.utils.UrlUtils=var3845, $z14=var3642}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	r3 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r4 = "*";	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if $z0 != 0 goto $r17 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers");	$r17 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers");	$r18 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory(java.lang.String)>("providers");	$z14 = staticinvoke <org.apache.dubbo.common.utils.UrlUtils: boolean isMatchCategory(java.lang.String,java.lang.String)>($r17, $r18);	if $z14 != 0 goto $z1 = virtualinvoke r2.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("enabled", 1);	return 0
;block_num 3