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

(declare-sort var2524 0)
(declare-sort var3768 0)
(declare-sort var479 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-fun var479-init () var479)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var479 String) void)
(declare-const null-String String)
(declare-const null-var3768 var3768)
(declare-const var536 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var536 null-String)))
(declare-const var2832 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2832 null-String)))
(declare-const var2951 var3768) ; Statement: r2 := @parameter2: java.util.Map 
(assert (not (= var2951 null-var3768)))
(define-const var349 Int 0) ; Statement: i9 = 0 
(assert true)
(define-const var56 Int (length/-134980193 var2832)) ; Statement: i10 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true)
(define-const var319 Int (indexOf/-1037706067 var2832 35)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(35) 
(define-const var3515 Int (cast-from-Int-to-Int -1)) ; Statement: $i17 = (int) -1 
 ; Statement: if i0 == $i17 goto r19 = null 
(assert (= var319 var3515)) ; Cond: i0 == $i17 
(define-const var2305 String null-String) ; Statement: r19 = null 
(assert true)
(define-const var994 Int (indexOf/-1209756239 var2832 "://")) ; Statement: $i8 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("://") 
 ; Statement: if $i8 < 0 goto i11 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":/") 
(assert (not (< var994 0))) ; Negate: Cond: $i8 < 0  
 ; Statement: if $i8 != 0 goto r19 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i8) 
(assert (not (not (= var994 0)))) ; Negate: Cond: $i8 != 0  
(define-const var13 var479 var479-init) ; Statement: $r25 = new java.lang.IllegalStateException 
(define-const var1113 String String-init) ; Statement: $r24 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1113)) ; Statement: specialinvoke $r24.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1113!1 String)
(assert (= var1113!1 ""))
(assert true)
(define-const var406 String (append/672562846 var1113!1 "url missing protocol: \u0022")) ; Statement: $r15 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("url missing protocol: \"") 
(declare-const var1113!2 String)
(assert (= var1113!2 (str.++ var1113!1 "url missing protocol: \u0022")))
(assert true)
(define-const var3573 String (append/672562846 var406 var536)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8) 
(declare-const var406!1 String)
(assert (= var406!1 (str.++ var406 var536)))
(assert true)
(define-const var839 String (append/672562846 var3573 "\u0022")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\"") 
(declare-const var3573!1 String)
(assert (= var3573!1 (str.++ var3573 "\u0022")))
(assert true)
(define-const var680 String (toString/-2075883882 var839)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var13 var680)) ; Statement: specialinvoke $r25.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r18) 

(declare-const var13!1 var479)
(declare-const var680!1 String)
 ; Statement: throw $r25 
(check-sat)
; {length/-134980193=([java.lang.String], int), indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), indexOf/-1209756239=([java.lang.String, java.lang.String], int), var479-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var536=r8, var2524=null_type, var2832=r0, var3768=java.util.Map, var2951=r2, var349=i9, var56=i10, var319=i0, var3515=$i17, var2305=r19, var994=$i8, var479=java.lang.IllegalStateException, var13=$r25, var1113=$r24, var406=$r15, var3573=$r16, var839=$r17, var680=$r18}
; {r8=var536, null_type=var2524, r0=var2832, java.util.Map=var3768, r2=var2951, i9=var349, i10=var56, i0=var319, $i17=var3515, r19=var2305, $i8=var994, java.lang.IllegalStateException=var479, $r25=var13, $r24=var1113, $r15=var406, $r16=var3573, $r17=var839, $r18=var680}
;seq <java.lang.String: int length()>;	<java.lang.String: int indexOf(int)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r2 := @parameter2: java.util.Map;	i9 = 0;	i10 = virtualinvoke r0.<java.lang.String: int length()>();	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(35);	$i17 = (int) -1;	if i0 == $i17 goto r19 = null;	r19 = null;	$i8 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("://");	if $i8 < 0 goto i11 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":/");	if $i8 != 0 goto r19 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i8);	$r25 = new java.lang.IllegalStateException;	$r24 = new java.lang.StringBuilder;	specialinvoke $r24.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("url missing protocol: \"");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r8);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\"");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r25.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r18);	throw $r25
;block_num 4