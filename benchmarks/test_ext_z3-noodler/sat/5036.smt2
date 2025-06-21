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

(declare-sort var1581 0)
(declare-sort var1269 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-fun var1269-init () var1269)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1269 String) void)
(declare-const null-String String)
(declare-const var2788 String) ; Statement: r15 := @parameter0: java.lang.String 
(assert (not (= var2788 null-String)))
(declare-const var2341 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2341 null-String)))
(declare-const var1379 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1379 null-String)))
(define-const var1084 String var1379) ; Statement: r16 = r0 
(define-const var1638 String null-String) ; Statement: r17 = null 
(define-const var765 String null-String) ; Statement: r18 = null 
(define-const var408 String null-String) ; Statement: r19 = null 
(define-const var416 String null-String) ; Statement: r20 = null 
(define-const var787 Int 0) ; Statement: i11 = 0 
(assert true)
(define-const var549 Int (indexOf/-1209756239 var2788 "://")) ; Statement: i12 = virtualinvoke r15.<java.lang.String: int indexOf(java.lang.String)>("://") 
 ; Statement: if i12 < 0 goto i13 = virtualinvoke r15.<java.lang.String: int indexOf(java.lang.String)>(":/") 
(assert (not (< var549 0))) ; Negate: Cond: i12 < 0  
 ; Statement: if i12 != 0 goto r16 = virtualinvoke r15.<java.lang.String: java.lang.String substring(int,int)>(0, i12) 
(assert (not (not (= var549 0)))) ; Negate: Cond: i12 != 0  
(define-const var853 var1269 var1269-init) ; Statement: $r9 = new java.lang.IllegalStateException 
(define-const var1173 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1173)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1173!1 String)
(assert (= var1173!1 ""))
(assert true)
(define-const var3060 String (append/672562846 var1173!1 "url missing protocol: \u0022")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("url missing protocol: \"") 
(declare-const var1173!2 String)
(assert (= var1173!2 (str.++ var1173!1 "url missing protocol: \u0022")))
(assert true)
(define-const var1244 String (append/672562846 var3060 var2788)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r15) 
(declare-const var3060!1 String)
(assert (= var3060!1 (str.++ var3060 var2788)))
(assert true)
(define-const var2167 String (append/672562846 var1244 "\u0022")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\"") 
(declare-const var1244!1 String)
(assert (= var1244!1 (str.++ var1244 "\u0022")))
(assert true)
(define-const var2118 String (toString/-2075883882 var2167)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var853 var2118)) ; Statement: specialinvoke $r9.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r14) 

(declare-const var853!1 var1269)
(declare-const var2118!1 String)
 ; Statement: throw $r9 
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), var1269-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2788=r15, var1581=null_type, var2341=r1, var1379=r0, var1084=r16, var1638=r17, var765=r18, var408=r19, var416=r20, var787=i11, var549=i12, var1269=java.lang.IllegalStateException, var853=$r9, var1173=$r10, var3060=$r11, var1244=$r12, var2167=$r13, var2118=$r14}
; {r15=var2788, null_type=var1581, r1=var2341, r0=var1379, r16=var1084, r17=var1638, r18=var765, r19=var408, r20=var416, i11=var787, i12=var549, java.lang.IllegalStateException=var1269, $r9=var853, $r10=var1173, $r11=var3060, $r12=var1244, $r13=var2167, $r14=var2118}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.String;	r16 = r0;	r17 = null;	r18 = null;	r19 = null;	r20 = null;	i11 = 0;	i12 = virtualinvoke r15.<java.lang.String: int indexOf(java.lang.String)>("://");	if i12 < 0 goto i13 = virtualinvoke r15.<java.lang.String: int indexOf(java.lang.String)>(":/");	if i12 != 0 goto r16 = virtualinvoke r15.<java.lang.String: java.lang.String substring(int,int)>(0, i12);	$r9 = new java.lang.IllegalStateException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("url missing protocol: \"");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r15);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\"");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r14);	throw $r9
;block_num 3