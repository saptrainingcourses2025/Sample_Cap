using { AdminService } from './admin-service';

annotate AdminService.Books with {

    title @mandatory;

    author @assert: (case
    when not exists author then 'Specified Author does not exist'
    end);

    genre @mandatory @assert: (case
    when not exists genre then 'Specified Genre does not exist'
    end);

    price @assert.range : [1,111];
    stock @assert.range : [0,_];
}

annotate AdminService.Authors with {
    name @mandatory;

    dateOfBirth @assert: (case
        when dateOfBirth > dateOfDeath then 'Date of birth cannot be after date of death'
    end);

    dateOfDeath @assert: (case
        when dateOfDeath < dateOfBirth then 'Date of death cannot be before date of birth'
    end);

}

annotate AdminService.Genres with {
    name @mandatory;

    parent @assert: (case
        when parent == ID then 'A genre cannot be its own parent'
    end);
}



