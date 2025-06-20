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

(declare-sort var1683 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3502 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3502 null-String)))
(declare-const var3165 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var3165 null-String)))
(declare-const var1481 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var1481 null-Int)))
(declare-const var693 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var693 null-String)))
(define-const var665 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var665)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var665!1 String)
(assert (= var665!1 ""))
(assert true)
(define-const var2633 String (append/672562846 var665!1 var3502)) ; Statement: $r2 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var665!2 String)
(assert (= var665!2 (str.++ var665!1 var3502)))
(assert true)
;(assert (append/672562846 var2633 "://")) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("://") 
(declare-const var2633!1 String)
(assert (= var2633!1 (str.++ var2633 "://")))
(assert true)
(define-const var3038 String (append/672562846 var665!2 var3165)) ; Statement: $r4 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var665!3 String)
(assert (= var665!3 (str.++ var665!2 var3165)))
(assert true)
(define-const var1775 String (append/-1166366385 var3038 58)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var3038!1 String)
(assert (str.prefixof var3038 var3038!1))
(assert true)
;(assert (append/-1001720160 var1775 var1481)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1775!1 String)
(assert (str.prefixof var1775 var1775!1))
(assert (not (and true (and (> (str.len var693) 0) (<= 0 0)))))
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3502=r1, var1683=null_type, var3165=r3, var1481=i0, var693=r6, var665=$r8, var2633=$r2, var3038=$r4, var1775=$r5, var1840=$c1, var1489=$i2, var1487=$r7}
; {r1=var3502, null_type=var1683, r3=var3165, i0=var1481, r6=var693, $r8=var665, $r2=var2633, $r4=var3038, $r5=var1775, $c1=var1840, $i2=var1489, $r7=var1487}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.String: char charAt(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.String: char charAt(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	i0 := @parameter2: int;	r6 := @parameter3: java.lang.String;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("://");	$r4 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$c1 = virtualinvoke r6.<java.lang.String: char charAt(int)>(0);	$i2 = (int) $c1;	if $i2 == 47 goto virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r7 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 2